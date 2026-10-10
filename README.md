# Drowsiness Detection with YOLOv5 and PyTorch

Real-time drowsiness detection built on a fine-tuned YOLOv5 model. The system detects whether a person appears **awake** or **drowsy** from images, recorded video, or a live webcam feed.

## Capabilities

- Detect objects in still images
- Detect objects in pre-recorded video
- Real-time detection from a webcam via OpenCV
- Fine-tune a custom drowsiness model with YOLOv5 + PyTorch
- Run real-time drowsiness inference end to end

## How it works

[`ob.ipynb`](ob.ipynb) walks through the full pipeline: loading YOLOv5 through `torch.hub`, running inference on a frame source, collecting a custom labelled dataset, fine-tuning the detector on that dataset, and finally streaming webcam frames through the trained model with OpenCV.

Fine-tuning rather than training from scratch matters here — the drowsiness dataset is small, so starting from COCO-pretrained weights supplies general feature extraction and only the detection head needs to specialise.

## Running it

```bash
pip install -r requirements.txt
jupyter notebook ob.ipynb
```

A `Dockerfile` is included if you prefer a reproducible container over a local environment.

> [!NOTE]
> `requirements.txt` pins `tensorflow`, but the notebook performs detection with **PyTorch** (`torch`, via YOLOv5). You will need `torch`, `torchvision` and `ultralytics`/YOLOv5 installed; TensorFlow is not required for the detection path.

Webcam inference needs a camera accessible to the process. Note that `opencv-python-headless` is listed, which omits GUI support — use the standard `opencv-python` build if you want `cv2.imshow` preview windows.

## Use cases

1. **Driver monitoring systems** — detect drowsiness at the wheel.
2. **Workplace safety** — fatigue monitoring in transportation, manufacturing and healthcare.
3. **Aviation safety** — pilots facing long hours of sustained concentration.
4. **Security operations** — operators monitoring surveillance feeds for extended shifts.
5. **Healthcare** — tracking patient drowsiness during procedures or under sedation.

## Limitations

- Trained weights are not committed, so the fine-tuning step must be re-run to reproduce detection results.
- Accuracy depends heavily on the size and diversity of the collected dataset; a model trained on one person in one lighting condition will not generalise.
- Drowsiness here is inferred from appearance in a single frame, with no temporal smoothing — brief blinks can register as drowsy without aggregation over time.
