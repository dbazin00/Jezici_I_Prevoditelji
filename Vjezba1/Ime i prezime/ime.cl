class Main inherits IO {
	ime: String <- new String;
	prezime: String <- new String;
	main():Object {
		{
			out_string("\n\nUnesite ime:\t");
			ime <- in_string();
			out_string("Unesite prezime:\t");
			prezime <- in_string();
			out_string(
				("\nDobrodosli, ")
				.concat(ime)
				.concat(" ")
				.concat(prezime)
				.concat("!\n\n")
			);
		}
	};
}; 


