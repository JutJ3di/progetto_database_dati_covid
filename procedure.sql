create or replace procedure posti_terapia(
regione IN analisi_dati_regionali.nome_regioni%type,
giorno IN analisi_dati_regionali.data%type
)
as
	begin
		declare
			posti_rimanenti integer;
			costante integer : = 0;
			saturazione exception;
		begin
		if (giorno < '25-feb-2020'or giorno > '03-Mag-2020') then
			DMS_OUTPUT.PUT_LINE ('Dati non pervenuti per il giorno: '||giorno); 
		else
			select (numero_posti_terapia_intensiva - terapia_intensiva) into posti_rimanenti
			from analisi_dati_regionali
			where nome_regioni =regioni and data =giorno;
				if(posti_rimanenti>costante) then
					DBMS_OUTPUT.PUT_LINE('Il numero di posti rimanenti in terapia intensiva nella regione '||regione||'il giorno'||giorno||'è :'||posti_rimanenti||'situazione non grave');
 				else
					reaise saturazione;
			end if;

			exception when saturazione then
			DBMS_OUTPUT.PUT_LINE('Il numero di posti rimanenti in terapia intensiva nella regione '||regione||'il giorno'||giorno||'è:'||posti_rimanenti||'Attenzione:situazione grave');
			
			end;
end posti_terapia;

exec posti_terapia ('Campania','20-feb-2020');
exec posti_terapia ('Campania','20-Mag-2020');
exec posti_terapia ('Lombardia','20-feb,2020')
exec posti_terapia ('Lombardia','20-Mag-2020');
exec posti_terapia ('Lombardia','20-apr-2020');
exec posti_terapia ('Lombardia','20-feb-2020');			
