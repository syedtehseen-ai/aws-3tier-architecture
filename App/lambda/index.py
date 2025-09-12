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
            # Extract user info from JWT claims
            claims = event.get("requestContext", {}).get("authorizer", {}).get("jwt", {}).get("claims", {})
            user = claims.get("cognito:username", "anonymous")

            body = json.loads(event.get("body", "{}"))
            item = {
                "id": body.get("id", context.aws_request_id[:8]),
                "task": body.get("task", "Untitled"),
                "user": user
            }
            table.put_item(Item=item)
            return {"statusCode": 201, "body": json.dumps(item)}
        
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
