from typing import get_args
from fastapi import FastAPI
from mangum import Mangum
from pydantic import BaseModel
from starlette.types import Message

app = FastAPI()


class HelloParam(BaseModel):
    name: str


@app.get("/hello")
def get_hello(name: str = None):
    if name:
        message = f"Hello {name} !"
    else:
        message = "Hello Visitor !"
    return {"message": message}


@app.post("/hello")
def post_hello(param: HelloParam):
    if param.name:
        message = f"Hello {param.name} !"
    else:
        message = "Hello Visitor !"
    return {"message": message}


handler = Mangum(app)
