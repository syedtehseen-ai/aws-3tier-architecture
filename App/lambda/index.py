import json
import os
import boto3
from boto3.dynamodb.conditions import Key

TABLE_NAME = os.environ.get("TABLE_NAME", "items")
dynamodb = boto3.resource("dynamodb")
table = dynamodb.Table(TABLE_NAME)

def lambda_handler(event, context):
    print("Received event:", json.dumps(event))
    method = event.get("requestContext", {}).get("http", {}).get("method", "GET")

    try:
        if method == "GET":
            response = table.scan()
            items = response.get("Items", [])
            return {
                "statusCode": 200,
                "body": json.dumps({"items": items})
            }

        elif method == "POST":
            body = json.loads(event.get("body", "{}"))
            item_id = body.get("id", str(int(context.aws_request_id[:8], 16)))
            body["id"] = item_id
            table.put_item(Item=body)
            return {
                "statusCode": 201,
                "body": json.dumps({"id": item_id})
            }

        else:
            return {
                "statusCode": 405,
                "body": json.dumps({"error": "Method not allowed"})
            }

    except Exception as e:
        print("Error:", str(e))
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }
