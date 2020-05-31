const jsonMessagesPath = __dirname + "/../assets/jsonMessages/";
const jsonFilePath = __dirname + "/../assets/";
const jsonMessages = require(jsonMessagesPath + "bd");
const connect = require('../config/connectMySQL');

// https://stackabuse.com/reading-and-writing-json-files-with-node-js/
const fs = require('fs');

function read(req, res) {
    connect.con.query(
        'SELECT t.idTarefa, t.nome, t.data, t.duracao, tt.tipo, v.nome as voluntarioNome, t.active '
        + ' FROM tarefa t INNER JOIN tipoTarefa tt on t.idTipoTarefa = tt.idTipoTarefa '
        + ' INNER JOIN Voluntario v on v.idVoluntario = t.idVoluntario '
        + ' order by t.idTarefa desc', 
        function(err, rows, fields) {
        if (err) {
            console.log(err);
            res.status(jsonMessages.db.dbError.status).send(jsonMessages.db.dbError);
        }
        else {
            if (rows.length == 0) {
                res.status(jsonMessages.db.noRecords.status).send(jsonMessages.db.noRecords);
            }
            else {
                console.log(`${rows.length} Registos lidos com sucesso (BD)`);
                res.send(rows);
            }
        }
    });
}

function readID(req, res) {
    const idTarefa = req.sanitize('id').escape();
    const post = { idTarefa: idTarefa };
    connect.con.query(
        'SELECT t.idTarefa, t.nome, t.data, t.duracao, tt.tipo, v.nome as voluntarioNome, t.active '
        + ' FROM tarefa t INNER JOIN tipoTarefa tt on t.idTipoTarefa = tt.idTipoTarefa '
        + ' INNER JOIN Voluntario v on v.idVoluntario = t.idVoluntario '
        + ' WHERE ? order by t.idTarefa desc', post,
        function(err, rows, fields) {
        if (err) {
            console.log(err);
            res.status(jsonMessages.db.dbError.status).send(jsonMessages.db.dbError);
        }
        else {
            console.log(post);
            if (rows.length == 0) {
                res.status(jsonMessages.db.noRecords.status).send(jsonMessages.db.noRecords);
            }
            else {
                console.log(`${rows.length} Registo lido com sucesso (BD)`);
                res.send(rows);
            }
        }
    });
}


function save(req, res) {
    console.log(req.body);
    const nome = req.sanitize('nome').escape();
    const data = req.sanitize('data').escape();
    const duracao = req.sanitize('duracao').escape();
    const idVoluntario = req.sanitize('idVoluntario').escape();
    const idTipoTarefa = req.sanitize('idTipoTarefa').escape();
    req.checkBody("nome", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("data", "Insira uma data.").matches(/^\d{4}-\d{2}-\d{2}$/);
    req.checkBody("idVoluntario", "Insira um ID de Voluntário válido").isNumeric();
    req.checkBody("idTipoTarefa", "Insira um ID de TipoTarefa válido").isNumeric();
    const errors = req.validationErrors();    
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (nome != "NULL" && typeof(nome) != "undefined" && idVoluntario != "NULL" && idTipoTarefa != "NULL") {
            const post = { nome: nome, data: data, duracao: duracao,  idVoluntario: idVoluntario, idTipoTarefa: idTipoTarefa, active: 1 };
            //criar e executar a query de gravação na BD para inserir os dados presentes no post
            const query = connect.con.query('INSERT INTO tarefa SET ?', post, function(err, rows, fields) {
                console.log(query.sql);
                if (!err) {
                    console.log(`Registo ${rows.insertId} inserido com sucesso`);
                    res.status(jsonMessages.db.successInsert.status).location(rows.insertId).send(jsonMessages.db.successInsert);
                }
                else {
                    console.log(err);
                    res.status(jsonMessages.db.dbError.status).send(jsonMessages.db.dbError);
                }
            });
        }
        else
            res.status(jsonMessages.db.requiredData.status).end(jsonMessages.db.requiredData);
    }
}

function update(req, res) {
    //console.log(req.body);
    const nome = req.sanitize('nome').escape();
    const data = req.sanitize('data').escape();
    const duracao = req.sanitize('duracao').escape();
    const idVoluntario = req.sanitize('idVoluntario').escape();
    const idTipoTarefa = req.sanitize('idTipoTarefa').escape();
    const idTarefa = req.sanitize('id').escape();
    req.checkBody("nome", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("data", "Insira uma data.").matches(/^\d{4}-\d{2}-\d{2}$/);
    req.checkBody("idVoluntario", "Insira um ID de Voluntário válido").isNumeric();
    req.checkBody("idTipoTarefa", "Insira um ID de TipoTarefa válido").isNumeric();
    req.checkParams("id", "Insira um ID de Tarefa válido").isNumeric();
    const errors = req.validationErrors();
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (idTarefa != "NULL" && typeof(nome) != 'undefined' && idVoluntario != "NULL" && idTipoTarefa != "NULL" && typeof(idTarefa) != 'undefined') {
            const post = { nome: nome, data: data, duracao: duracao,  idVoluntario: idVoluntario, idTipoTarefa: idTipoTarefa, active: 1 };
            const update = [nome, data, duracao, idVoluntario, idTipoTarefa, idTarefa];
            const query = connect.con.query('UPDATE tarefa SET nome =?, data =?, duracao =?, idVoluntario =?, idTipoTarefa =? WHERE idTarefa=?', update, function(err, rows, fields) {
                console.log(query.sql);
                if (!err) {
                    console.log(`Registo ${idTarefa} atualizado com sucesso`);
                    res.status(jsonMessages.db.successUpdate.status).send(jsonMessages.db.successUpdate);
                }
                else {
                    console.log(err);
                    res.status(jsonMessages.db.dbError.status).send(jsonMessages.db.dbError);
                }
            });
        }
        else
            res.status(jsonMessages.db.requiredData.status).end(jsonMessages.db.requiredData);
    }
}

function deleteL(req, res) {
    //console.log(req.body);
    const idTarefa = req.sanitize('id').escape();
    const update = [0, idTarefa];
    const query = connect.con.query('UPDATE tarefa SET active = ? WHERE idTarefa=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idTarefa} desativado com sucesso`);
            res.status(jsonMessages.db.successDelete.status).send(jsonMessages.db.successDelete);
        }
        else {
            console.log(err);

            res.status(jsonMessages.db.dbError.status).send(jsonMessages.db.dbError);
        }
    });
}

function deleteF(req, res) {
    //console.log(req.body);
    const idTarefa = req.sanitize('id').escape();
    const update = idTarefa;
    const query = connect.con.query('DELETE FROM tarefa WHERE idTarefa=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idTarefa} apagado com sucesso`);
            res.status(jsonMessages.db.successDeleteU.status).send(jsonMessages.db.successDeleteU);
        }
        else {
            console.log(err);
            res.status(jsonMessages.db.dbError.status).send(jsonMessages.db.dbError);
        }
    });
}


module.exports = {
    read: read,
    readID: readID,
    save: save,
    update: update,
    deleteL: deleteL,
    deleteF: deleteF,
};
