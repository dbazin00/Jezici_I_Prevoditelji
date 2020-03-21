class Main inherits IO {
	p : Int <- new Int;
	b : Int <- new Int;
	rezultat : Int <- new Int;
	main():Object {{
		out_string("\n\nUnesite broj:\t");
		b <- (new A2I).a2i(
			in_string()
		);
		out_string("Unesite potenciju:\t");
		p <- (new A2I).a2i(
			in_string()
		);
		
		rezultat <- rezultat(b, p);

		out_string(
				("\nRezultat:\n")
				.concat((new A2I).i2a(rezultat))
				.concat("\n\n")
		);
	}};
	
	rezultat(b:Int, p:Int):Int {
		let rezultat:Int <- 1 in {
			while(not(p=0)) loop {
				rezultat <- rezultat*b;
				p <- p-1;
			} pool;
			rezultat;
		}
	};
}; 