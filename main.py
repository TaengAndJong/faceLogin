from fastapi import FastAPI, UploadFile, File
import uvicorn

app = FastAPI()

@app.get("/")
def root():
    return {"message": "server running"}

# @app.post("/embedding")
# async def embedding(file: UploadFile = File(...)):
#     contents = await file.read()
#
#     # TODO: 여기서 얼굴 임베딩 처리
#     return {"embedding": [0.1, 0.2, 0.3]}


if __name__ == "__main__":
    # host를 0.0.0.0으로 해야 컨테이너 외부(스프링부트 등)에서 접속이 가능합니다.
    uvicorn.run(app, host="0.0.0.0", port=8000)