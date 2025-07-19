# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  },
]

user_input = ""
while user_input != "bye"
  pp "Hello! How may I help you today?"

  user_input = gets.chomp

  if user_input != "bye"
  message_list.push({ "role" => "user", "content" => user_input })
# Call the API to get the next message from GPT
    api_response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: message_list
      }
    )

    choices = api_response.fetch("choices")
    first_choice = choices.at(0)
    message = first_choice.fetch("message")
    assistant_response = message["content"]

    pp assistant_response

    message_list.push({ "role" => "assistant", "content" => assistant_response })
  end
end
pp "Bye! Have a good day!"
