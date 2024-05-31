document.addEventListener("DOMContentLoaded", function() {

    var addprovBtn = document.getElementById("addprov");
    var modal = document.getElementById("miModal");
    
    // Obtener el elemento <span> que cierra la ventana modal
    var span = document.getElementsByClassName("close")[0];
    
    // Cuando el usuario haga clic en el botón "Addprov", abrir la ventana modal
    addprovBtn.onclick = function() {
        modal.style.display = "block";
    }
    
    // Cuando el usuario haga clic en <span> (x), cerrar la ventana modal
    span.onclick = function() {
        modal.style.display = "none";
    }
    
    // Cuando el usuario haga clic fuera del contenido de la ventana modal, cerrarla
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    var addprovBtn = document.getElementById("addprod");
    var modal = document.getElementById("miModal2");
    
    // Obtener el elemento <span> que cierra la ventana modal
    var span = document.getElementsByClassName("close")[0];
    
    // Cuando el usuario haga clic en el botón "Addprov", abrir la ventana modal
    addprovBtn.onclick = function() {
        modal.style.display = "block";
    }
    
    // Cuando el usuario haga clic en <span> (x), cerrar la ventana modal
    span.onclick = function() {
        modal.style.display = "none";
    }
    
    // Cuando el usuario haga clic fuera del contenido de la ventana modal, cerrarla
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // Obtener el campo de fecha
    var fechaCreacionInput = document.getElementById("fechaCreacion");
    // Obtener la fecha actual
    var fechaActual = new Date();
    // Formatear la fecha actual como YYYY-MM-DD
    var fechaFormatoISO = fechaActual.toISOString().split('T')[0];
    // Establecer la fecha por defecto en el campo de fecha
    fechaCreacionInput.value = fechaFormatoISO;
    fechaCreacionInput.setAttribute('readonly', 'readonly');

    var proveedorSelector = document.getElementById("proveedor");
    var productoSelector = document.getElementById("producto");
    var tablaFormulario = document.getElementById("tabla-formulario").getElementsByTagName('tbody')[0];
    var enviarFormularioBtn = document.getElementById("enviarFormularioBtn");
    var divTotalFactura = document.getElementById("totalFactura");
    

    proveedorSelector.addEventListener("change", function() {
        var proveedorSeleccionado = this.options[this.selectedIndex];
        var proveedorId = proveedorSeleccionado.value;
        var direccion = proveedorSeleccionado.getAttribute("data-direc");
        var telefono = proveedorSeleccionado.getAttribute("data-tel")


        var divNitProveedor = document.getElementById("nitproveedor");
        var divDireccionProveedor = document.getElementById("direccion");
        var divTelefonoProveedor = document.getElementById("telefono");

        divNitProveedor.textContent = proveedorId;
        divDireccionProveedor.textContent = direccion;
        divTelefonoProveedor.textContent = telefono;


        proveedorSelector.disabled = true;

        productoSelector.innerHTML = '<option value="">Producto</option>';
        if (proveedorId) {
            $.ajax({
                url: obtenerProductosURL, // URL para obtener los productos por proveedor
                method: "GET",
                data: { proveedor_id: proveedorId },
                dataType: "json",
                success: function(data) {
                    data.forEach(function(producto) {
                        var option = document.createElement("option");
                        option.value = producto.id;
                        option.textContent = producto.nombre;
                        option.dataset.proveedorId = producto.proveedor_id;
                        productoSelector.appendChild(option);
                    });
                },
                error: function(xhr, textStatus, errorThrown) {
                    console.error('Error al obtener los productos: ' + errorThrown);
                }
            });
        }
        });

    
    productoSelector.addEventListener("change", function() {
        var productoSeleccionado = this.options[this.selectedIndex];
        var id_producto = productoSeleccionado.value;
        var nombre_producto = productoSeleccionado.textContent;
        var id_proveedor = productoSeleccionado.dataset.proveedorId;
        var fechaCreacion = document.getElementById("fechaCreacion").value;
        var numeroFactura = document.getElementById("numeroFactura").value

        // Deshabilitar opción seleccionada
        productoSeleccionado.disabled = true;
    
        var nuevaFila = tablaFormulario.insertRow();
        nuevaFila.insertCell().textContent = id_producto; // 1
        nuevaFila.insertCell().textContent = nombre_producto; //2
        // Celdas editables
        var celdaCantidad = nuevaFila.insertCell(); //3
        celdaCantidad.contentEditable = true; // Hacer la celda de cantidad editable 
        var celdaPrecio = nuevaFila.insertCell(); //4
        celdaPrecio.contentEditable = true; // Hacer la celda de precio editable
        // Celda para el total
        var celdaTotal = nuevaFila.insertCell(); //5
           celdaTotal.textContent = "0";  // Inicializa el total a 0
        nuevaFila.insertCell().textContent = fechaCreacion; //6
        nuevaFila.insertCell().contentEditable = true; //7
        nuevaFila.insertCell().textContent= id_proveedor;
        nuevaFila.insertCell().textContent = numeroFactura;
        

        var celdaBorrar = nuevaFila.insertCell(9);
        var iconoBorrar = document.createElement('span');
        iconoBorrar.classList.add('delete');
        iconoBorrar.style.color = 'red'; 
        iconoBorrar.style.textAlign= 'center';
        iconoBorrar.textContent = 'X';
        celdaBorrar.appendChild(iconoBorrar);

        // Añadir evento para manejar la eliminación de la fila
        iconoBorrar.addEventListener('click', function() {
            var filaParaEliminar = this.closest('tr');
            filaParaEliminar.remove();

            // Reactivar la opción en el selector
            productoSelector.options[productoSelector.selectedIndex].disabled = false;
            // Opcionalmente, restablecer el selector al estado inicial
            productoSelector.selectedIndex = 0;
        });
            // Función para calcular el total de la fila
        // Función para calcular el total de una fila
        function actualizarTotal() {
            var fila = this.parentNode;
            var celdaCantidad = fila.cells[2];
            var celdaPrecio = fila.cells[3];
            var celdaTotal = fila.cells[4];

            var cantidad = parseFloat(celdaCantidad.textContent);
            var precioUnitario = parseFloat(celdaPrecio.textContent);
            celdaTotal.textContent = (cantidad * precioUnitario).toFixed(2);

            // Calcular y actualizar el total de la factura
            actualizarTotalFactura();
        }

        // Función para calcular y actualizar el total de la factura
        function actualizarTotalFactura() {
            var totalFactura = 0;
            var filas = tablaFormulario.rows;
            for (var i = 0; i < filas.length; i++) {
                var celdaTotal = parseFloat(filas[i].cells[4].textContent);
                totalFactura += isNaN(celdaTotal) ? 0 : celdaTotal; // Ignorar celdas vacías o no numéricas
            }
            // Mostrar el total de la factura dentro del div de total factura
            divTotalFactura.textContent = "Total de la factura: $" + totalFactura.toFixed(2);
        }

        // Asignar eventos onblur para calcular y actualizar el total
        celdaCantidad.onblur = actualizarTotal;
        celdaPrecio.onblur = actualizarTotal;
    });



    enviarFormularioBtn.addEventListener("click", function() {
        var confirmacion = confirm("¿Estás seguro de que deseas enviar la información?");
        if (confirmacion) {
            var datosTabla = [];
            var totalFactura = 0; // Variable para almacenar el valor total de la tabla
            var filas = tablaFormulario.rows;
            for (var i = 0; i < filas.length; i++) {
            var fila = filas[i];
            var celdas = fila.cells;
        // Verificar que la fila tenga las celdas esperadas antes de acceder a sus contenidos
                if (celdas.length >= 7) {
                    var id_producto = celdas[0].textContent;
                    var nombre = celdas[1].textContent;
                    var cantidad = parseFloat(celdas[2].textContent);
                    var precioUnitario = parseFloat(celdas[3].textContent);
                    var celdaTotal = parseFloat(celdas[4].textContent);
                    var fechaCreacion = celdas[5].textContent;
                    var unidad = celdas[6].textContent;
                    var idProveedor = celdas[7].textContent;
                    var numeroFactura = celdas[8].textContent;  
                    var recibido = false; // Inicializar recibido como false
                    var filaDatos = {
                        
                        idProducto: id_producto,
                        nombreProducto: nombre,
                        cantidad: cantidad,
                        precioUnitario: precioUnitario,
                        totalFila: celdaTotal,
                        fechaCreacion: fechaCreacion,
                        idProveedor: idProveedor, // Incluir id_proveedor
                        valorUnidad: unidad,
                        factura : numeroFactura,
                        recibido : recibido,
                        
                    };
                totalFactura += celdaTotal;
                datosTabla.push(filaDatos);
            } else {
                console.error("La fila", i, "no tiene las celdas esperadas.");
            }
        }
        var datosFormulario = JSON.stringify(datosTabla);
        divTotalFactura.textContent = "Total de la factura: $" + totalFactura.toFixed(2);
    }
        // Enviar los datos al servidor usando AJAX
        $.ajax({
            url: nuevaOrden, // Asegúrate que esta URL se renderiza correctamente en la plantilla
            method: "POST",
            headers: { "X-CSRFToken": getCookie("csrftoken") },
            contentType: 'application/json',
            data: JSON.stringify({datos_tabla: datosTabla, totalFactura: totalFactura}),
            success: function(response) {
                console.log(datosTabla)
                console.log("Datos enviados correctamente: ", response);
                limpiarModal();
                alert("Datos guardados correctamente.");
            },
            error: function(xhr, textStatus, errorThrown) {
                console.log('Error en la solicitud AJAX: ' + textStatus);
                alert("Error al enviar los datos. Por favor, intenta de nuevo.");
            }
        });
    });
    




});

function getCookie(name) {
var cookieValue = null;
if (document.cookie && document.cookie !== '') {
    var cookies = document.cookie.split(';');
    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i].trim();
        // Verificar si la cookie comienza con el nombre deseado
        if (cookie.substring(0, name.length + 1) === (name + '=')) {
            cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
            break;
        }
    }
}
return cookieValue;
}

function limpiarModal() {
// Resetear el select de proveedores
$('#proveedor').val($('#proveedor option:first').val());

// Limpiar información del proveedor
$('#nitproveedor').text('NIT');
$('#direccion').text('DIRECCION');
$('#telefono').text('TELEFONO');


// Resetear el select de productos
$('#producto').html('<option value="">Producto</option>');

// Limpiar la tabla, manteniendo solo la cabecera
$('#tabla-formulario tbody').empty();

$('#numeroFactura').val('');
}
// Escuchar el evento de cambio en el selector
// Obtener referencia al botón de cerrar modal

function calcularTotalFactura() {
    var tablaFormulario = document.getElementById("tabla-formulario").getElementsByTagName('tbody')[0];
    var totalFactura = 0;
    var filas = tablaFormulario.rows;
    for (var i = 0; i < filas.length; i++) {
        var celdas = filas[i].cells;
        if (celdas.length >= 5) { // Ajusta esto según la cantidad de celdas que contengan el precio total
            var celdaTotal = parseFloat(celdas[4].textContent);
            if (!isNaN(celdaTotal)) {
                totalFactura += celdaTotal;
            }
        }
    }
    return totalFactura;
}

