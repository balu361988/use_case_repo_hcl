import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_ids = ['i-040734f6bb53c10eb']
    print(f"Starting EC2 instance {instance_ids[0]}...")
    response = ec2.start_instances(InstanceIds=instance_ids)
    print(f"Response: {response}")
    return {"status": "Instance started", "details": response}
