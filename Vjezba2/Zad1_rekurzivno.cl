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
		if(p=0) then
			1
		else
			b*rezultat(b, p-1)
		fi 
	};
}; 