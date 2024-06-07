document.addEventListener("DOMContentLoaded", function() {
    
    var fechaCreacionInput = document.getElementById("fechaCreacion");
    var fechaActual = obtenerFechaActual();
    var fechaFormatoISO = fechaActual.toISOString().split('T')[0];
    var addprovBtn = document.getElementById("addprov");
    var modal = document.getElementById("miModal");
    var modal2 = document.getElementById("miModal2")
    var addprod = document.getElementById("addprod")
    var form = document.getElementById("miModal").querySelector("form");
    var span = document.getElementsByClassName("close")[0];
    var span2 = document.getElementsByClassName("closemodal2")[0];
    const selectedProducts = new Set();
    
    
    
    fechaCreacionInput.value = fechaFormatoISO;
    fechaCreacionInput.setAttribute('readonly', 'readonly');

    $(document).ready(function() {
        $('#id_cliente').select2();
        $('#producto').select2();

    });
    $('#producto').on('change', function() {
        const selectedOption = $(this).find('option:selected');
        const productoId = selectedOption.val();
        const productoNombre = selectedOption.text().split('--')[1];

        if (productoId && !selectedProducts.has(productoId)) {
            $.ajax({
                url: materiasprimas, // Actualiza esta URL según tu configuración
                data: { producto_id: productoId },
                success: function(response) {
                    if (response.success) {
                        const materiasPrimas = response.materias_primas;

                        selectedProducts.add(productoId);

                        const newRow = $('<tr>');

                        const idCell = $('<td>').text(productoId);
                        const nombreCell = $('<td>').text(productoNombre);
                        const cantidadCell = $('<td>');
                        const cantidadInput = $('<input>').attr('type', 'number').val(1);
                        cantidadCell.append(cantidadInput);

                        const opcionesCell = $('<td>');
                        const deleteButton = $('<button>').text('Eliminar').addClass('delete-btn');
                        deleteButton.on('click', function() {
                            newRow.remove();
                            selectedProducts.delete(productoId);
                            $('#producto option[value="' + productoId + '"]').prop('disabled', false);
                        });
                        opcionesCell.append(deleteButton);

                        newRow.append(idCell, nombreCell, cantidadCell, opcionesCell);

                        $('#tabla-formulario tbody').append(newRow);

                        $('#producto option[value="' + productoId + '"]').prop('disabled', true);
                        $('#producto').val(null).trigger('change');

                        // Actualizar los contenedores de existencias y materias primas
                        updateInfoContainers(materiasPrimas);
                    } else {
                        alert('Error: ' + response.error);
                    }
                },
                error: function() {
                    alert('Error al validar el producto.');
                }
            });
        }
    });

    // Añade evento de clic a las filas de la tabla
    $('#tabla-formulario').on('click', 'tr', function() {
        const productoId = $(this).data('productoId');
        
        $.ajax({
            url: materiasprimas, // Asegúrate de que esta URL coincide con tu configuración de Django
            data: { producto_id: productoId },
            success: function(response) {
                if (response.success) {
                    const materiasPrimas = response.materias_primas;

                    // Actualizar los contenedores de existencias y materias primas
                    updateInfoContainers(materiasPrimas);
                } else {
                    alert('Error: ' + response.error);
                }
            },
            error: function() {
                alert('Error al validar el producto.');
            }
        });
    });

    function updateInfoContainers(materiasPrimas) {
        let existenciasHtml = '<h4>Existencias Inventario</h4>';
        let materiasPrimasHtml = '<h4>Materias Primas</h4>';

        materiasPrimas.forEach(mp => {
            existenciasHtml += `<p>${mp.nombre} (Código: ${mp.codigo}) - Cantidad en Inventario: ${mp.cantidad_actual}</p>`;
            materiasPrimasHtml += `<p>${mp.nombre} (Código: ${mp.codigo}) - Cantidad Requerida: ${mp.cantidad_requerida}</p>`;
        });

        $('#existencias-inventario').html(existenciasHtml);
        $('#materias-primas').html(materiasPrimasHtml);
    }
    $('#id_cliente').on('change', function() {
        const selectedOption = $(this).find('option:selected');
        const nit = selectedOption.data('nit');
        const direccion = selectedOption.data('direccion');
        const telefono = selectedOption.data('telefono');

        // Llenar los divs con los datos del cliente seleccionado
        $('#nitproveedor').text(`${nit}`);
        $('#direccion').text(`${direccion}`);
        $('#telefono').text(`${telefono}`);
    });

    
    $(document).ready(function() {
        // Hacer la solicitud AJAX para obtener el número de producción
        $.ajax({
            url: obtenerorden,
            method: 'GET',
            success: function(data) {
                if (data.numero_orden !== null) {
                    $('#numeroFactura').val(data.numero_orden);
                } else {
                    alert('Error al obtener el número de producción');
                }
            },
            error: function() {
                alert('Error en la solicitud AJAX');
            }
        });
    });
    // Cuando el usuario haga clic en el botón "Addprov", abrir la ventana modal
    addprovBtn.onclick = function() {
        modal.style.display = "block";
    }
    addprod.onclick = function() {
        modal2.style.display = "block";
    }
    
    // Cuando el usuario haga clic en <span> (x), cerrar la ventana modal
    span.onclick = function() {
        modal.style.display = "none";
    }
    span2.onclick = function() {
        modal2.style.display = "none";
    }
    
    // Cuando el usuario haga clic fuera del contenido de la ventana modal, cerrarla
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        if (event.target == modal2) {
            modal2.style.display = "none";
        }
    }

    form.addEventListener("submit", function(event) {
        // Mostrar una confirmación antes de enviar los datos
        var confirmacion = confirm("¿Estás seguro de que deseas enviar los datos?");
        if (!confirmacion) {
            // Cancelar el envío del formulario si el usuario cancela
            event.preventDefault();
        } else {
            // Verificar si el proveedor ya existe
            var nit = document.getElementById('nit').value;
            if (Clientes.objects.filter(nit=nit).exists()) {
                // Mostrar una alerta indicando que el proveedor ya existe
                alert("¡El proveedor con este NIT ya existe en la base de datos!");
                // Detener el envío del formulario
                event.preventDefault();
            }
        }
    });
    // Agregar evento al enviar el formulario

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
function obtenerFechaActual() {
    // Obtener la fecha y hora actuales en UTC
    var fechaActual = new Date();
    
    // Obtener el desplazamiento horario en minutos desde UTC para la zona horaria de Colombia (UTC-5)
    var offsetColombia = -5 * 60;
    
    // Calcular la fecha y hora en la zona horaria de Colombia
    var fechaColombia = new Date(fechaActual.getTime() + offsetColombia * 60 * 1000);
    
    return fechaColombia;
}