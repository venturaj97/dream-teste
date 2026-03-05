import os
from datetime import datetime, timezone
import boto3

s3 = boto3.client("s3")

def lambda_handler(event, context):
    bucket = os.environ["BUCKET_NAME"]

    # Nome do arquivo = data/hora exata da execução (UTC por padrão)
    # Formato ISO sem ":" para evitar problemas em alguns sistemas
    now = datetime.now(timezone.utc)
    key = now.strftime("%Y-%m-%dT%H-%M-%SZ") + ".txt"

    content = f"Execution time (UTC): {now.isoformat()}\n"

    s3.put_object(
        Bucket=bucket,
        Key=key,
        Body=content.encode("utf-8"),
        ContentType="text/plain",
    )

    return {"ok": True, "bucket": bucket, "key": key}