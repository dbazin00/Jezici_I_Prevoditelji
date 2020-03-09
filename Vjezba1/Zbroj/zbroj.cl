class Main inherits IO {
	br1: Int <- new Int;
	br2: Int <- new Int;
	main():Object {
		{
			out_string("\n\nUnesite prvi broj:\t");
			br1 <- (new A2I).a2i(
				in_string()
			);
			out_string("Unesite drugi broj:\t");
			br2 <- (new A2I).a2i(
				in_string()
			);
			out_string(
				("\nRezultat:\n")
				.concat((new A2I).i2a(br1))
				.concat("\t+\t")
				.concat((new A2I).i2a(br2))
				.concat("\t=\t")
				.concat((new A2I).i2a(br1 + br2))
				.concat("\n\n")
			);
		}
	};
}; 

