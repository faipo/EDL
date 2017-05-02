Program expressividade ;
type 
	tupla= record
		nome: string[10];
		num: integer;
	end;
var tup: array[1..4] of tupla;
i:integer;
function reverso(texto:string):string;
    var saida:string;
    tam,i:integer;
    begin
    tam:=length(texto)+1;
    for i:=1 to tam do
    saida:=saida+texto[tam-i+1];
    reverso:=saida;
    end;
 Begin
 	tup[1].nome:='Rafael';
 	tup[1].num:=250;
 	tup[2].nome:='Joao';
 	tup[2].num:=40;
 	tup[3].nome:='Maria';
	tup[3].num:=79;
 	tup[4].nome:='Camilo';
 	tup[4].num:=126;
	write('[');
     for i :=1 to 4 do
	begin
		write('("',reverso(tup[i].nome),'",',tup[i].num+length(tup[i].nome),')');
		if i<>4 then
			write(',');
	end;
	write(']');
 End.
