insert into membroComissao(nome, instituto, pais, active)
values
("Tim Berners-Lee", "Universidade de Southampton", "Reino Unido", 1),
("Larry Page", "Universidade de Stanford", "Estados Unidos da América", 1),
("Robert Kahn", "Instituto de Tecnologia de Massachusetts", "Estados Unidos da América", 1),
("Vint Cerf", "Universidade de Stanford", "Estados Unidos da América", 1);

insert into conf_membroComissao(idConference, idMembro)
select 1, idMembro from membroComissao;
