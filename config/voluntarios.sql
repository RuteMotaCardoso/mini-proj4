insert into voluntario(nome, email, cargo, habilitacao, lingua, idTipoTarefa, active)
values
("Sara Silva","sara.silva@uab.pt","Estudante","Secundário","Inglês",1,1) , 
("Duarte Oliveira","duarte.oliveira@uab.pt","Estudante","Licenciatura","Inglês",1,1) , 
("Maria Inês Castro","maria.castro@uab.pt","Estudante","Licenciatura","Inglês",2,1) , 
("Pedro Duarte","pedro.duarte@uab.pt","Estudante","Secundário","Frances",2,1) , 
("Francisco Pinto","francisco.pinto@uab.pt","Estudante","Licenciatura","Inglês",4,1) , 
("Diana Telles","diana.telles@uab.pt","Estudante","Licenciatura","Alemão",4,1) , 
("Ana Campos","ana.campos@uab.pt","Estudante","Licenciatura","Inglês",5,1) , 
("José Jesualdo","jose.jesualdo@uab.pt","Estudante","Licenciatura","Inglês",5,1) , 
("Ricardo Jorge","ricardo.jorge@uab.pt","Estudante","Licenciatura","Inglês",6,1) , 
("André Antunes", "andre.antunes@uab.pt", "Estudante", "Licenciatura", "Inglês", 6, 0);

insert into conf_Voluntario(idConference, idVoluntario)
select 1, idVoluntario from voluntario
where idVoluntario <= 6;
