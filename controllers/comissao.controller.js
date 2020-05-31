const jsonMessagesPath = __dirname + "/../assets/jsonMessages/";
const jsonFilePath = __dirname + "/../assets/";
const jsonMessages = require(jsonMessagesPath + "bd");
const connect = require('../config/connectMySQL');

function read(req, res) {
    connect.con.query('SELECT idMembro, nome, instituto, pais, active FROM membroComissao order by idMembro desc', function(err, rows, fields) {
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
    const idmembro = req.sanitize('id').escape();
    const post = { idMembro: idmembro };
    connect.con.query('SELECT idMembro, nome, instituto, pais, active FROM membroComissao WHERE ? order by idMembro desc', post, function(err, rows, fields) {
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
    const instituto = req.sanitize('instituto').escape();
    const pais = req.sanitize('pais').escape();
    req.checkBody("nome", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("instituto", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("pais", "Insira apenas texto").matches(/^[A-zÀ-ú ]+$/i);
    const errors = req.validationErrors();    
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (nome != "NULL" && pais != "NULL" && typeof(nome) != "undefined") {
            const post = { nome: nome, instituto: instituto, pais: pais, active: 1 };
            //criar e executar a query de gravação na BD para inserir os dados presentes no post
            const query = connect.con.query('INSERT INTO membroComissao SET ?', post, function(err, rows, fields) {
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
    const nome = req.sanitize('nome').escape();
    const instituto = req.sanitize('instituto').escape();
    const pais = req.sanitize('pais').escape();
    const idMembro = req.sanitize('id').escape();
    req.checkBody("nome", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("instituto", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("pais", "Insira apenas texto").matches(/^[A-zÀ-ú ]+$/i);
    req.checkParams("id", "Insira um ID de MembroComissao válido").isNumeric();
    const errors = req.validationErrors();
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (idMembro != "NULL" && typeof(nome) != 'undefined' &&  typeof(idMembro) != 'undefined') {
            const update = [nome, instituto, pais, idMembro];
            const query = connect.con.query('UPDATE membroComissao SET nome =?, instituto =?, pais=? WHERE idMembro=?', update, function(err, rows, fields) {
                console.log(query.sql);
                if (!err) {
                    console.log(`Registo ${idMembro} atualizado com sucesso`);
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
    const idMembro = req.sanitize('id').escape();
    const update = [0, idMembro];
    const query = connect.con.query('UPDATE membroComissao SET active = ? WHERE idMembro=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idMembro} desativado com sucesso`);
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
    const idMembro = req.sanitize('id').escape();
    const update = idMembro;
    const query = connect.con.query('DELETE FROM membroComissao WHERE idMembro=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idMembro} apagado com sucesso`);
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
