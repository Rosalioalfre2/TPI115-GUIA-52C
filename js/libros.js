/*Odena por título: ascendente o descendente */
function ordenar(n) {
    var tabla, rows, cambiar, i, x, y, sincambiar, dir, contador = 0;
    tabla = document.getElementById('tabla1');
    cambiar = true;
    /*Ordenar ascendente*/
    dir = "asc";

    while (cambiar) {
        /*Si no se realiza ningún cambio */
        cambiar = false;
        rows = tabla.rows;
        /*Recorrer todas las filas de la tabla, excepto la primera que contiene los encabezados */
        for (i = 1; i < (rows.length - 1); i++) {
            /*Si no hay cambios */
            sincambiar = false;
            /*Obtener los dos elementos a comparar, uno de la fila actual y uno de la siguiente fila */
            x = rows[i].getElementsByTagName("TD")[n];
            y = rows[i + 1].getElementsByTagName("TD")[n];
            /*Comprobar si las filas deben cambiar */
            if (dir == "asc") {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                    sincambiar = true;
                    break; /*Interrumpir */
                }
            } else if (dir == "desc") {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                    sincambiar = true;
                    break; /*Interrumpir */
                }
            }
        }
        if (sincambiar) {
            /*Si se ha interrumpido, marcar que se ha realizado un cambio */
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            cambiar = true;
            contador++; /*Aumentar contador de cambio */
        } else {
            /*Si no hay cambio y la dirección es "asc", establecer la dirección en "desc" y volver a ejecutar el ciclo while*/
            if (contador == 0 && dir == "asc") {
                dir = "desc";
                cambiar = true;
            }
        }
    }
}

/*Actualiza desde la columna Accion */
function actualizar(b) {
    document.getElementById("is1").value = document.getElementById("i" + b.id).innerHTML;
    document.getElementById("t1").value = document.getElementById("t" + b.id).innerHTML;
    document.getElementById("a1").value = document.getElementById("a" + b.id).innerHTML;
    document.getElementById("anio1").value = document.getElementById("an" + b.id).innerHTML;
    document.getElementById("update").checked = true;
}

/*Filtrar titulo y autor */
function limpiarInput() {
    document.getElementById("is1").value = ""
    document.getElementById("t1").value = ""
    document.getElementById("a1").value = ""
    document.getElementById("new").checked = true
    document.getElementById("filtro").disabled = true
}

limpiarInput()

document.getElementById("bt").addEventListener('keyup', function (e) 
{
    desactivar()
})

document.getElementById("ba").addEventListener('keyup', function (e) 
{
    desactivar() 
})

const desactivar = () => {
    let titulo = document.getElementById("bt").value;
    let autor = document.getElementById("ba").value;
    if (titulo === "" && autor === "") {
        document.getElementById("filtro").disabled = true
        filtrar()
    } else {
        document.getElementById("filtro").disabled = false
    }
}

function filtrar() {
    let columnatitulo = ""
    let columnaautor = ""
    let titulo = document.getElementById("bt").value.toLowerCase();
    let autor = document.getElementById("ba").value.toLowerCase();
    let inicio = 11
    let tr = document.getElementsByTagName("tr")
    let longitud = tr.length
    for (let index = inicio; index < longitud; index++) {
        //console.log(tr[index])
        columnatitulo = tr[index].cells[2].innerHTML.toLowerCase()
        columnaautor = tr[index].cells[3].innerHTML.toLowerCase()
        if (!columnatitulo.includes(titulo)|| !columnaautor.includes(autor)) {
            tr[index].style.display = 'none'
        } else {
            tr[index].style.display = ''
        }
    }
}







