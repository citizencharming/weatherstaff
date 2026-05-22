{
  config,
  pkgs,
  ...
}: {
  hardware.nvidia-container-toolkit.enable = true;

  boot.kernel.sysctl = {
    "vm.max_map_count" = 262144;
  };

  systemd.services.vllm-blue-fairy = {
    description = "vLLM Engine: The Blue Fairy (Qwen-2.5-7B-Instruct AWQ)";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.python311Packages.vllm}/bin/python -m vllm.entrypoints.openai.api_server \
          --model /mnt/vault/data/models/qwen-2.5-7b-instruct-awq \
          --port 8080 \
          --gpu-memory-utilization 0.90 \
          --max-model-len 8192
      '';
      Restart = "always";
      Environment = "CUDA_VISIBLE_DEVICES=0";
    };
  };

  systemd.services.llamacpp-server = {
    description = "Lami.cpp Bare-Metal Inference Daemon";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.llama-cpp}/bin/llama-server \
          --model /mnt/vault/data/models/mistral-7b-instruct-v0.3.Q4_K_M.gguf \
          --port 8080 \
          --ctx-size 8192 \
          --n-gpu-layers 32 \
          --flash-attn
      '';
      Restart = "always";
      User = "root";
    };
  };

  systemd.services.rwkv-the-witch = {
    description = "RWKV Engine: The Witch The Weal the Wyrm";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.rwkv-cpp}/bin/rwkv-server \
          --model /mnt/vault/data/models/rwkv-v6-14b.bin \
          --port 8083 \
          --ctx-size 16384
      '';
      Restart = "always";
    };
  };

  environment.systemPackages = with pkgs; [
    aichat
    crush
  ];

  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      # Interface
      localai = {
        image = "quay.io/go-skynet/local-ai:latest";
        ports = ["8081:8080"];
        environment = {
          "MODELS_PATH" = "/models";
          "THREADS" = "12";
        };
        volumes = ["/mnt/vault/data/localai/models:/models"];
      };

      open-webui = {
        image = "ghcr.io/open-webui/open-webui:main";
        ports = ["3000:8080"];
        environment = {
          "OPENAI_API_BASE_URL" = "http://127.0.0.1:8080/v1";
          "OPENAI_API_KEY" = "not-applicable";
        };
        volumes = ["/var/lib/open-webui:/app/backend/data"];
        extraOptions = ["--network=host"];
      };

      sillytavern = {
        image = "ghcr.io/sillytavern/sillytavern:latest";
        ports = ["8002:8000"];
        volumes = ["/mnt/vault/data/sillytavern:/home/node/app/data"];
      };

      # Vector DB
      qdrant = {
        image = "qdrant/qdrant:latest";
        ports = ["6333:6333"];
        volumes = ["/mnt/vault/data/qdrant:/qdrant/storage"];
      };

      vectoradmin = {
        image = "mintplexlabs/vectoradmin:latest";
        ports = ["3010:3001"];
        environment = {
          "SERVER_PORT" = "3010";
        };
        volumes = ["/mnt/vault/data/vectoradmin:/app/server/storage"];
      };

      # RAG
      anythingllm = {
        image = "mintplexlabs/anythingllm:latest";
        ports = ["3001:3001"];
        environment = {
          "SERVER_PORT" = "3001";
          "LLM_PROVIDER" = "generic-openai";
          "VECTOR_DB" = "qdrant";
        };
        volumes = ["/mnt/vault/data/anythingllm:/app/server/storage"];
      };

      surfsense = {
        image = "ghcr.io/surfsense/surfsense:latest";
        ports = ["3002:3000"];
        environment = {
          "DATABASE_URL" = "file:/data/surfsense.db";
          "QDRANT_URL" = "http://127.0.0.1:6333";
        };
        volumes = ["/mnt/vault/data/surfsense:/data"];
      };

      open-notebook = {
        image = "ghcr.io/open-notebook/open-notebook:latest";
        ports = ["3003:8080"];
        environment = {
          "LLM_ENDPOINT" = "http://127.0.0.1:8080/v1";
        };
        volumes = ["/mnt/vault/data/opennotebook:/data"];
      };

      khoj = {
        image = "ghcr.io/khoj-ai/khoj:latest";
        ports = ["3009:8000"];
        environment = {
          "KHOJ_NO_TELEMETRY" = "true";
        };
        volumes = ["/mnt/vault/data/khoj:/root/.khoj"];
      };

      # Memory
      mem0 = {
        image = "mem0ai/mem0:latest";
        ports = ["8000:8000"];
        environment = {
          "LLM_API_BASE" = "http://127.0.0.1:8080/v1";
          "VECTOR_DB_URL" = "http://127.0.0.1:6333";
        };
        volumes = ["/mnt/vault/data/mem0:/app/data"];
      };

      mempalace = {
        image = "ghcr.io/mempalace/mempalace:latest";
        ports = ["8001:8001"];
        environment = {
          "STORAGE_PATH" = "/data";
        };
        volumes = ["/mnt/vault/data/mempalace:/data"];
      };

      # Observability
      phoenix = {
        image = "arizephoenix/phoenix:latest";
        ports = ["6006:6006" "4317:4317"]; # 4317 required for OTLP trace ingestion
        volumes = ["/mnt/vault/data/phoenix:/data"];
      };

      observer = {
        image = "ghcr.io/observer/observer:latest";
        ports = ["6007:6007"];
        environment = {
          "LOG_LEVEL" = "debug";
        };
        volumes = ["/mnt/vault/data/observer:/logs"];
      };

      # Model Context Protocol
      mcp-infrastructure-fs = {
        image = "downloads.mcp.dev/server/filesystem:latest";
        environment = {"ALLOWED_DIRECTORIES" = "/mnt/vault/data";};
        volumes = ["/mnt/vault/data:/mnt/vault/data"];
        extraOptions = ["--network=host"];
      };

      mcp-claraverse-bridge = {
        image = "ghcr.io/modelcontextprotocol/server-claraverse:latest";
        environment = {
          "CLARAVERSE_API_URL" = "http://127.0.0.1:9000";
          "TARGET_WORKSPACE_DIR" = "/workspace";
        };
        volumes = ["/mnt/vault/data/workspaces:/workspace"];
        extraOptions = ["--network=host"];
      };

      claraverse-sandbox = {
        image = "ghcr.io/claraverse/sandbox-runtime:latest";
        ports = ["9000:9000"]; # Exposes the inner execution control layer
        volumes = [
          "/mnt/vault/data/workspaces:/workspace:rw" # Grants access only to isolated data paths
        ];
        environment = {
          "SANDBOX_ENV" = "production";
          "EXECUTION_TIMEOUT" = "30"; # Kills runaway agent loop calculations after 30 seconds
        };
        extraOptions = [
          "--cap-drop=ALL" # Strips all root capabilities from the container runtime
          "--security-opt=no-new-privileges" # Blocks processes from gaining elevated host rights
        ];
      };

      # Browser Automation

      perplexica-backend = {
        image = "itizer/perplexica-backend:latest";
        ports = ["3006:3001"];
        environment = {
          "SEARXNG_API_URL" = "http://127.0.0.1:8080"; # Assuming an existing SearXNG proxy
          "LLM_PROVIDER" = "custom";
          "CUSTOM_API_URL" = "http://127.0.0.1:8080/v1";
        };
        extraOptions = ["--network=host"];
      };

      perplexica-frontend = {
        image = "itizer/perplexica-frontend:latest";
        ports = ["3005:3000"];
        environment = {
          "NEXT_PUBLIC_API_URL" = "http://127.0.0.1:3006/api";
        };
        extraOptions = ["--network=host"];
      };

      hoarder = {
        image = "ghcr.io/hoarder-app/hoarder:latest";
        ports = ["3007:3000"];
        environment = {
          "OLLAMA_BASE_URL" = "http://127.0.0.1:8080"; # llama-cpp OpenAI compatibility layer
        };
        volumes = ["/mnt/vault/data/hoarder:/data"];
      };

      firecrawl = {
        image = "mendableai/firecrawl:latest";
        ports = ["3008:3000"];
        # Firecrawl requires a Redis broker. Ensure a Redis container is spun up in parallel if not present.
        environment = {
          "REDIS_URL" = "redis://127.0.0.1:6379";
        };
        extraOptions = ["--network=host"];
      };

      redis-broker = {
        image = "redis:alpine";
        ports = ["6379:6379"];
      };

      # Browser Automation
    };
  };
}
