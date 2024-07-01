## 參考資料

[Dockerfile 介绍 - Docker Tips](https://dockertips.readthedocs.io/en/latest/docker-image/dockerfile-intro.html)

### 步驟

1. 建立 hello.py

    ```py
    print("hello docker")
    ```

1. 建立 Dockerfile

    ```dockerfile
    FROM ubuntu:22.04
    RUN apt-get update && \
        DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y python3.10 python3-pip python3.10-dev
    ADD hello.py /
    CMD ["python3", "/hello.py"]
    ```

1. 編譯 Dockerfile

    ```sh
    docker image build -t hello .
    docker run -it hello
    ```
