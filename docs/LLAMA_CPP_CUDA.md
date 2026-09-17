This is a short guide how I got CUDA installed and compiled `llama-cpp-python` with GPU support on Void GNU Linux. These steps are as follows:
1. **Download the installation files**: Go to the [CUDA toolkit website](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Debian&target_version=13). Select Linux -> x86_64 -> Debian -> 12 (or 13) -> runfile (local).
2. **Set executable permission**: `chmod +x ./cuda_*.run`
3. **Install using the correct flags**:
   `sudo ./cuda_*.run --silent --override --toolkit --no-opengl-libs`
4. **Add to path**: The toolkit installs to `/usr/local/cuda`. Add the following to your `.zshrc` or `.bashrc`:
   ```bash
   export PATH="/usr/local/cuda/bin:$PATH"
   export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
   ```
5. **Compile with uv**:
   ```bash
   CMAKE_ARGS="-DGGML_CUDA=on -DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc" FORCE_CMAKE=1 uv pip install --no-cache-dir --force-reinstall --compile-bytecode llama-cpp-python
   ```
