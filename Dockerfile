# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.5.1-base

# install custom nodes into comfyui (first node with --mode remote to fetch updated cache)
RUN comfy node install --exit-on-fail comfyui_layerstyle@2.0.33 --mode remote
RUN comfy node install --exit-on-fail comfyui-impact-pack@8.28.2
RUN comfy node install --exit-on-fail comfyui-kjnodes@1.2.3
RUN comfy node install --exit-on-fail comfyui-easy-use@1.3.5
RUN comfy node install --exit-on-fail ComfyLiterals
# The following unknown_registry nodes could not be resolved (no aux_id provided) and were skipped:
# - Reroute
# - Reroute

# download models into comfyui
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/vae/qwen_image_vae.safetensors --relative-path models/vae --filename qwen_image_vae.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image_ComfyUI/resolve/main/split_files/text_encoders/qwen_2.5_vl_7b_fp8_scaled.safetensors --relative-path models/clip --filename qwen_2.5_vl_7b_fp8_scaled.safetensors
RUN comfy model download --url https://huggingface.co/Comfy-Org/Qwen-Image-Edit_ComfyUI/resolve/main/split_files/diffusion_models/qwen_image_edit_2509_fp8_e4m3fn.safetensors --relative-path models/diffusion_models --filename qwen_image_edit_2509_fp8_e4m3fn.safetensors
RUN comfy model download --url https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-8steps-V1.0.safetensors --relative-path models/loras --filename Qwen-Image-Lightning-8steps-V1.0.safetensors
RUN comfy model download --url https://huggingface.co/lightx2v/Qwen-Image-Lightning/resolve/main/Qwen-Image-Lightning-4steps-V1.0.safetensors --relative-path models/loras --filename Qwen-Image-Lightning-4steps-V1.0.safetensors
RUN comfy model download --url https://huggingface.co/Phr00t/Qwen-Image-Edit-Rapid-AIO/blob/main/v14/Qwen-Rapid-AIO-NSFW-v14.1.safetensors --relative-path models/diffusion_models --filename Qwen-Rapid-AIO-NSFW-v14.1.safetensors
# RUN # Could not find URL for Qwen-Image-Edit-F2P.safetensors
# RUN # Could not find URL for consistence_edit_v2.safetensors
# RUN # Could not find URL for Qwen_Snofs_1_3.safetensors
# RUN # Could not find URL for realistic skin no plastic qwen[prski]-gmr.safetensors

# copy all input data (like images or videos) into comfyui (uncomment and adjust if needed)
# COPY input/ /comfyui/input/
