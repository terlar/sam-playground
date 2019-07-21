import { APIGatewayProxyEvent, APIGatewayProxyResult, Context } from 'aws-lambda'

export async function lambdaHandler(
  _event: APIGatewayProxyEvent,
  context: Context
): Promise<APIGatewayProxyResult> {



  try {
    return {
      statusCode: 200,
      body: JSON.stringify({
        message: "hello world",
      }),
    }



  } catch (err) {
    console.log(err)
    return err
  }
}
