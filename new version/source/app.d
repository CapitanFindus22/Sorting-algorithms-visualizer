import std.stdio;

void main()
{

	byte[] arr = new byte[5];

	arr ~= [2,2,2];

	foreach (byte key; arr)
	{
		printf("%d\n",key);
	}

	writeln("Edit source/app.d to start your project.");
}
