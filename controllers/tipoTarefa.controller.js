const jsonMessagesPath = __dirname + "/../assets/jsonMessages/";
const jsonFilePath = __dirname + "/../assets/";
const jsonMessages = require(jsonMessagesPath + "bd");
const connect = require('../config/connectMySQL');

// https://stackabuse.com/reading-and-writing-json-files-with-node-js/
const fs = require('fs');

function read(req, res) {
    connect.con.query('SELECT idTipoTarefa, tipo, cor, active FROM tipoTarefa order by idTipoTarefa desc', function(err, rows, fields) {
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
    const idTipoTarefa = req.sanitize('id').escape();
    const post = { idTipoTarefa: idTipoTarefa };
    connect.con.query('SELECT idTipoTarefa, tipo, cor, active FROM tipoTarefa WHERE ? order by idTipoTarefa desc', post, function(err, rows, fields) {
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
    const tipo = req.sanitize('tipo').escape();
    const cor = req.sanitize('cor').escape();
    req.checkBody("tipo", "Insira apenas texto").matches(/^[A-zÀ-ú ]+$/i);
    const errors = req.validationErrors();    
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (tipo != "NULL" && typeof(tipo) != "undefined") {
            const post = { tipo: tipo, cor: cor, active: 1 };
            //criar e executar a query de gravação na BD para inserir os dados presentes no post
            const query = connect.con.query('INSERT INTO tipoTarefa SET ?', post, function(err, rows, fields) {
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
        else {
            res.status(jsonMessages.db.requiredData.status).end(jsonMessages.db.requiredData);
        }
    }
}

function update(req, res) {
    //console.log(req.body);
    const tipo = req.sanitize('tipo').escape();
    const cor = req.sanitize('cor').escape();
    const idTipoTarefa = req.sanitize('id').escape();
    req.checkBody("tipo", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkParams("id", "Insira um ID de Tipo Tarefa válido").isNumeric();
    const errors = req.validationErrors();
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (idTipoTarefa != "NULL" && typeof(tipo) != 'undefined' && typeof(idTipoTarefa) != 'undefined') {
            const update = [tipo, cor, idTipoTarefa];
            const query = connect.con.query('UPDATE tipoTarefa SET tipo =?, cor =? WHERE idTipoTarefa=?', update, function(err, rows, fields) {
                console.log(query.sql);
                if (!err) {
                    console.log(`Registo ${idTipoTarefa} atualizado com sucesso`);
                    res.status(jsonMessages.db.successUpdate.status).send(jsonMessages.db.successUpdate);
                }
                else {
                    console.log(err);
                    res.status(jsonMessages.db.dbError.status).send(jsonMessages.db.dbError);
                }
            });
        }
        else
            res.status(jsonMessages.db.requiredData.status).send(jsonMessages.db.requiredData);
    }
}

function deleteL(req, res) {
    //console.log(req.body);
    const idTipoTarefa = req.sanitize('id').escape();
    const update = [0, idTipoTarefa];
    const query = connect.con.query('UPDATE tipoTarefa SET active = ? WHERE idTipoTarefa=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idTipoTarefa} desativado com sucesso`);
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
    const idTipoTarefa = req.sanitize('id').escape();
    const update = idTipoTarefa;
    const query = connect.con.query('DELETE FROM tipoTarefa WHERE idTipoTarefa=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idTipoTarefa} apagado com sucesso`);
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
