module tgadmin.bot;

import std.json;
import std.net.curl;
import std.conv : to;
import std.experimental.logger;

enum API_URL = "https://api.telegram.org/bot";

struct Bot
{
	private
	{
		string _token;
	}

	this(string token)
	{
		_token = token;
	}

	Message[] getUpdates()
	{
		auto result = get(API_URL ~ _token ~ "/getUpdates").parseJSON;
		log(LogLevel.info, result);

		Message[] messages;
		foreach(size_t i, JSONValue object; result["result"])
		{
			auto message = Message.deserialise(object["message"]);
			messages ~= message;
		}

		return messages;
	}
}


struct Message
{
	Chat chat;
	long date;
	Contact from;
	long messageId;
	string text;

	static Message deserialise(JSONValue msg)
	{
		Message message;

		message.date = msg["date"].integer;
		message.messageId = msg["message_id"].integer;
		message.text = msg["text"].str;

		return message;
	}
}


struct Contact
{
	int id;
	string firstName;
	string lastName;
	string username;
}

struct Chat
{
	enum ChatType
	{
		PRIVATE = "private",
		GROUP = "group",
		SUPERGROUP = "supergroup",
		CHANNEL = "channel"
	}

	string id;
	string firstName;
	string lastName;
	string username;
	ChatType type;
	string title;
	long updateId;
}

struct Update
{
	bool ok;
	Message[] result;
}
