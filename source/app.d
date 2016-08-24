import std.stdio;

import tgadmin.bot;

enum AUTH_TOKEN = "267494113:AAEvZAmx96fe0iqDvuC8wF9E-TDeZjpNHIg";

void main()
{
	auto bot = Bot(AUTH_TOKEN);

	for(;;)
	{
		writeln("Polling for updates");
		auto updates = bot.getUpdates();

		foreach(update; updates)
		{
			writeln(" * Update is: ", update);
		}

	}
}
