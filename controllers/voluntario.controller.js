const jsonMessagesPath = __dirname + "/../assets/jsonMessages/";
const jsonFilePath = __dirname + "/../assets/";
const jsonMessages = require(jsonMessagesPath + "bd");
const connect = require('../config/connectMySQL');


function read(req, res) {
    connect.con.query('SELECT v.idVoluntario, v.nome, v.email, v.cargo, v.habilitacao, v.lingua, tt.tipo, v.active '
        + ' FROM Voluntario v INNER JOIN tipoTarefa tt on v.idTipoTarefa = tt.idTipoTarefa order by v.idVoluntario desc', 
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
    const idVoluntario = req.sanitize('id').escape();
    const post = { idVoluntario: idVoluntario };
    connect.con.query('SELECT v.idVoluntario, v.nome, v.email, v.cargo, v.habilitacao, lingua, tt.tipo, v.active '
        + ' FROM Voluntario v INNER JOIN tipoTarefa tt on v.idTipoTarefa = tt.idTipoTarefa '
        + ' WHERE ? order by v.idVoluntario desc', post, function(err, rows, fields) {
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
    const email = req.sanitize('email').escape();
    const habilitacao = req.sanitize('habilitacao').escape();
    const lingua = req.sanitize('lingua').escape();
    const cargo = req.sanitize('cargo').escape();
    const idTipoTarefa = req.sanitize('idTipoTarefa').escape();
    req.checkBody("nome", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("cargo", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("email", "Insira um url válido.").optional({ checkFalsy: true }).isURL();
    req.checkBody("lingua", "Insira apenas texto").matches(/^[A-zÀ-ú ]+$/i);
    req.checkBody("idTipoTarefa", "Insira um ID de TipoTarefa válido").isNumeric();
    const errors = req.validationErrors();    
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (nome != "NULL" && lingua != "NULL" && typeof(nome) != "undefined") {
            const post = { nome: nome, email: email, cargo: cargo, habilitacao: habilitacao,  lingua: lingua, idTipoTarefa: idTipoTarefa,  active: 1 };
            //criar e executar a query de gravação na BD para inserir os dados presentes no post
            const query = connect.con.query('INSERT INTO voluntario SET ?', post, function(err, rows, fields) {
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
    const email = req.sanitize('email').escape();
    const habilitacao = req.sanitize('habilitacao').escape();
    const lingua = req.sanitize('lingua').escape();
    const cargo = req.sanitize('cargo').escape();
    const idTipoTarefa = req.sanitize('idTipoTarefa').escape();
    const idVoluntario = req.sanitize('id').escape();
    req.checkBody("nome", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("cargo", "Insira apenas texto").matches(/^[a-zÀ-ú ]+$/i);
    req.checkBody("email", "Insira um url válido.").optional({ checkFalsy: true }).isURL();
    req.checkBody("lingua", "Insira apenas texto").matches(/^[A-zÀ-ú ]+$/i);
    req.checkBody("idTipoTarefa", "Insira um ID de TipoTarefa válido").isNumeric();
    req.checkParams("id", "Insira um ID de Voluntario válido").isNumeric();
    const errors = req.validationErrors();
    if (errors) {
        res.send(errors);
        return;
    }
    else {
        if (idVoluntario != "NULL" && typeof(nome) != 'undefined' && typeof(cargo) != 'undefined' && typeof(idTipoTarefa) != 'undefined' && typeof(idVoluntario) != 'undefined') {
            const update = [nome, email, cargo, habilitacao, lingua, idTipoTarefa, idVoluntario];
            const query = connect.con.query('UPDATE voluntario SET nome =?, email =?, cargo =?, habilitacao =?, lingua =?, idTipoTarefa =? WHERE idVoluntario=?', update, function(err, rows, fields) {
                console.log(query.sql);
                if (!err) {
                    console.log(`Registo ${idVoluntario} atualizado com sucesso`);
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
    const idVoluntario = req.sanitize('id').escape();
    const update = [0, idVoluntario];
    const query = connect.con.query('UPDATE Voluntario SET active = ? WHERE idVoluntario=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idVoluntario} desativado com sucesso`);
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
    const idVoluntario = req.sanitize('id').escape();
    const update = idVoluntario;
    const query = connect.con.query('DELETE FROM Voluntario WHERE idVoluntario=?', update, function(err, rows, fields) {
        console.log(query.sql);
        if (!err) {
            console.log(`Registo ${idVoluntario} apagado com sucesso`);
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
