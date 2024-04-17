function fInicio() {
    // Cargar dos combos

    fRellenaCombo('#al_cursos', 'al_cur_id');
    fRellenaCombo('#as_cursos', 'as_cur_id');

    fMostrarForm('#div_asignaturas')

}

function fMostrarForm(nombre_de_cual_con_almohadilla) {
    // Ocultar todos los formularios
    let lista_formularios = document.querySelectorAll("#div_modal > div");
    lista_formularios.forEach(item =>{
        item.style.display = "none";
    });
    // Muestro el que me pidan
    document.querySelector(nombre_de_cual_con_almohadilla).style.display = 'block'
    // Muestro la modal
    document.querySelector('#div_modal').style.display = 'flex'
}

function fOcultarForm() {
    document.querySelector("#div_modal").style.display = "none"
}
function fRellenaCombo(donde_lo_dejo, como_se_llama) {
    let sql = "SELECT * FROM cursos ORDER BY cur_nombre";
    const URL = "assets/php/servidor.php?peticion=EjecutarSelect&sql=" + sql;
    fetch(URL)
        .then((response) => response.json())
        .then((data) => {
            console.log("CURSOS CARGAR", data);
            let html = `<select id='${como_se_llama}' class='input'>`
            html += "<option></option>"
            data.datos.forEach(item => {
                html += `<option value="${item.cur_id}">${item.cur_nombre}</option>`
            });
            html += "</select>"
            document.querySelector(donde_lo_dejo).innerHTML = html
        })
}

function fMostrarCursos() {
    // Sacar titulo
    let titulo = "CURSOS ( ";
    titulo += `<span onclick="fPreparaFormCursos('a', 0)">`
    titulo+= `<i class="fas fa-plus" title="Añadir curso"></i>`
    titulo+= `</span>`;
    titulo += " )";
    document.querySelector("#section_titulo").innerHTML = titulo;
    // Pedir a BBDD
    let sql = "SELECT * FROM cursos ORDER BY cur_nombre";
    const URL = "assets/php/servidor.php?peticion=EjecutarSelect&sql=" + sql;
    // Mostrar
    fetch(URL)
        .then((response) => response.json())
        .then((data) => {
            console.log("CURSOS", data);
            let html = "<table>";
            html += "<tr>"
            html += "<th>NOMBRE<th>"
            html += "<th>PLAZAS<th>"
            html += "<th>ACCION<th>"
            html += "</tr>"
            data.datos.forEach(item => {
                html += "<tr>"
                html += `<td>${item.cur_nombre}</td>`
                html += `<td>${item.cur_plazas}</td>`
                html += `<td>`
                html += `<i class="fas fa-trash"></i>`
                html += `<i class="fas fa-edit"></i>`
                html += `</td>`
                html += "</tr>"
            });
            html += "</table>"
            document.querySelector("#section_table").innerHTML = html;
        })
}
function fPreparaFormCursos(para_que, id) {
    // Guardar id
    document.querySelector("#cur_id").value = id;
    // Borrar errores anteriores
    document.querySelector("#cur_error").innerHTML = ' ';
    // Analizar para_que
    if (para_que = 'a') {
        document.querySelector("#cur_nombre").value = ' ';
        document.querySelector("#cur_plazas").value = ' ';
        document.querySelector("#cur_A").style.display = "block"
        document.querySelector("#cur_M").style.display = "none"
        document.querySelector("#cur_B").style.display = "none"
    }
    fMostrarForm("#div_cursos")
}
function fCRUD(operacion) {
    let sql = "";
    let cur_id = document.querySelector("#cur_id").value;
    let cur_nombre = document.querySelector("#cur_nombre").value;
    let cur_plazas = document.querySelector("#cur_plazas").value;
    // VALIDAR CAMPOS
    if (operacion == 'a') {
        sql = `INSERT INTO cursos VALUES (null, '${cur_nombre}', '${cur_plazas}')`;
    }

    if (operacion == 'm') {
        sql = "UPDATE cursos SET cur_nombre = WHERE";
    }

    if (operacion == 'b') {
        sql = "DELETE FROM cursos WHERE";
    }
    // Enviar sql al servidor
    let URL = "assets/php/servidor.php?";
        if (operacion == 'a') {
            URL+= "peticion=EjecutarInsert";
        } else {
            URL+= "peticion=EjecutarUpdateDelete";
        }
    URL+= "&sql=" + sql;
    fetch(URL)
        .then((response) => response.json())
        .then((data) => {
            console.log("CRUD CURSOS", data)
    });
}
function fMostrarAsignaturas() {
    let sql = "SELECT * FROM cursos LEFT JOIN asignaturas ON cur_id = as_cur_id ORDER BY as_nombre, cur_nombre";
    const URL = "assets/php/servidor.php?peticion=EjecutarSelect&sql=" + sql;
    fetch(URL)
        .then((response) => response.json())
        .then((data) => {
            console.log("ASIGNATURAS", data);
            let html = "<table>";
            html += "<tr>"
            html += "<th>NOMBRE<th>"
            html += "<th>NOMBRE CURSO<th>"
            html += "<th>DESCRIPCIÓN<th>" // No sacar en formato tabla nunca
            html += "</tr>"
            data.datos.forEach(item => {
                if (item.as_nombre == null) {
                    item.as_nombre = "";
                }
                if (item.as_descripcion == null) {
                    item.as_descripcion = "";
                }
                html += "<tr>"
                html += `<td>${item.as_nombre}</td>`
                html += `<td>${item.cur_nombre}</td>`
                html += `<td>${item.as_descripcion}</td>`
                html += "</tr>"
            });
            html += "</table>"
            document.querySelector("section").innerHTML = html;
        })
}

function fMostrarAlumnos() {
    let sql = "SELECT * FROM alumnos LEFT JOIN cursos ON cur_id = al_cur_id ORDER BY al_nombre";
    const URL = "assets/php/servidor.php?peticion=EjecutarSelect&sql=" + sql;
    fetch(URL)
        .then((response) => response.json())
        .then((data) => {
            console.log("ALUMNOS", data);
            let html = "<table>";
            html += "<tr>"
            html += "<th>CURSO<th>"
            html += "<th>APELLIDOS<th>"
            html += "<th>NOMBRE<th>"
            html += "<th>FECHA<th>"    
            html += "</tr>"
            data.datos.forEach(item => {
                if (item.al_nombre == null) {
                    item.al_nombre = "";
                }
                if (item.al_apellidos == null) {
                    item.al_apellidos = "";
                }
                if (item.al_fnac == null) {
                    item.al_fnac = "";
                }
                html += "<tr>"
                html += `<td>${item.cur_nombre}</td>`
                html += `<td>${item.al_apellidos}</td>`
                html += `<td>${item.al_nombre}</td>`
                html += `<td>${item.al_fnac}</td>`
                html += "</tr>"
            });
            html += "</table>"
            document.querySelector("section").innerHTML = html;
        })
}
function fAnimales() {
    let valor = document.querySelector("#animales").value;
    let posicion = document.querySelector("#animales").selectedIndex;
    console.log(valor, posicion)
}
function fCursos() {
    let valor = document.querySelector("#combo_cursos").value;
    let posicion = document.querySelector("#combo_cursos").selectedIndex;
    console.log(valor, posicion)
}