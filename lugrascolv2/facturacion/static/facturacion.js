document.addEventListener('DOMContentLoaded', function() {
    $(document).ready(function() {
        $('#cliente').select2();
        $('#Bproducto').select2();
        $('#orden').select2();

        
        });
        // Obtener la fecha actual
        var fechaActual = obtenerFechaActual().toISOString().split('T')[0];
        // Formatear la fecha actual como YYYY-MM-DD
        $('#fechaActual').text(fechaActual).prop('readonly', 'readonly');
        // Establecer la fecha por defecto en el campo de fecha
    

        $('#cliente').on('change', function() {
            var selectedOption = $(this).find(':selected');
            var direccion = selectedOption.data('direccion');
            var telefono = selectedOption.data('telefono');
            var correo = selectedOption.data('correo');
            var nitCliente = selectedOption.data('nit')
    
            // Actualizar los spans con la información correspondiente
            $('#spanDireccion').text(direccion);
            $('#spanTelefono').text(telefono);
            $('#spanCorreo').text(correo);

            $.ajax({
                url: obtenerOrdenCliente, // URL donde se procesará la solicitud en Django
                type: 'GET',
                data: {
                    nit_cliente: nitCliente // Enviar el nit del cliente como parámetro GET
                },
                success: function(response) {
                    if (response.transacciones && response.transacciones.length > 0) {
                        console.log('Datos recibidos:', response.transacciones);
                        
                        // Limpiar el selector de órdenes
                        $('#orden').empty();
                        $('#orden').append('<option value=""># Orden</option>'); // Opción por defecto
                        
                        // Usar un conjunto para almacenar IDs únicos de orden
                        var idOrdenesSet = new Set();
                        
                        // Iterar sobre las transacciones recibidas y añadir IDs únicos al conjunto
                        response.transacciones.forEach(function(transaccion) {
                            idOrdenesSet.add(transaccion.id_orden);
                        });
                        
                        // Convertir el conjunto a un array para poder iterar y agregar al selector
                        var idOrdenesArray = Array.from(idOrdenesSet);
                        idOrdenesArray.forEach(function(idOrden) {
                            $('#orden').append('<option value="' + idOrden + '">' + idOrden + '</option>');
                        });
                    } else {
                        console.error('No se encontraron transacciones pendientes de facturación para este cliente.');
                        
                        // Limpiar el selector de órdenes en caso de no encontrar ninguna orden válida
                        $('#orden').empty();
                        $('#orden').append('<option value="">No se encontraron órdenes por facturar</option>');
                    }
                },
                error: function(xhr, status, error) {
                    console.error('Error al cargar las órdenes:', error);
                    
                    // Manejar el error de la petición AJAX
                    $('#orden').empty();
                    $('#orden').append('<option value="">Error al cargar órdenes</option>');
                }
            });

        });
        $('#orden').on('change', function() {
            var idOrden = $(this).val();  // Obtener el valor seleccionado (id_orden)
            var subtotal = 0;
            var ivaSobreSubtotalTotal = 0;
            var subtotalTotal =0;
        
            // Verificar si se seleccionó una opción válida
            if (idOrden) {
                // Llamar a la función para enviar la solicitud AJAX con el id_orden seleccionado
                $.ajax({
                    url: DatosFacturacion,  // URL donde se procesará la solicitud en Django
                    type: 'GET',  // Método de solicitud (GET o POST según tu configuración en Django)
                    data: {
                        id_orden: idOrden  // Datos a enviar, en este caso el id_orden seleccionado
                    },
                    success: function(response) {
                        // Manejar la respuesta exitosa de la vista Django aquí
                        console.log('Respuesta de Django:', response);
        
                        // Limpiar la tabla antes de agregar nuevos datos
                        $('#tabla-formulario tbody').empty();
        
                        // Verificar el estado del checkbox de IVA
                        var incluirIVA = $('#checkIva').prop('checked');
        
                        // Iterar sobre los datos recibidos y agregar filas a la tabla
                        $.each(response.datos, function(index, dato) {
                            // Determinar qué subtotal mostrar dependiendo de si se incluye IVA o no
                            var subtotal_venta_mostrar = incluirIVA ? dato.total_venta : dato.subtotal_venta;
                            var subtotal_venta_formateado = '$' + ' ' + subtotal_venta_mostrar.toLocaleString();
        
                            var fila = '<tr>' +
                                        '<td>' + dato.id_producto + '</td>' +
                                        '<td>' + dato.nombre + '</td>' +
                                        '<td>' + dato.cantidad + '</td>' +
                                        '<td>' + subtotal_venta_formateado + '</td>' +
                                       '</tr>';
        
                            $('#tabla-formulario tbody').append(fila);
        
                            // Calcular subtotal total solo si se incluye IVA
                            if (incluirIVA) {
                                subtotal += dato.total_venta  * dato.cantidad;
                                ivaSobreSubtotalTotal += (dato.total_venta * dato.cantidad * (dato.iva / 100));
                                subtotalTotal = (subtotal - ivaSobreSubtotalTotal);
                            } else {
                                subtotalTotal += dato.subtotal_venta * dato.cantidad;
                            }
                        });
        
                        // Calcular Precio Total
                        var precioTotal = incluirIVA ? (subtotalTotal + ivaSobreSubtotalTotal) : subtotalTotal;
        
                        // Mostrar los valores calculados
                        $('.ValorSubtotal').text('$ ' + subtotalTotal.toLocaleString());
                        $('.ValorIva').text(incluirIVA ? ('$ ' + ivaSobreSubtotalTotal.toLocaleString()) : '');
                        $('.Ptotal').text('$ ' + precioTotal.toLocaleString());
                    },
                    error: function(xhr, status, error) {
                        // Manejar errores de la solicitud AJAX aquí
                        console.error('Error en la solicitud AJAX:', error);
                    }
                });
            } else {
                console.log('Seleccionó una opción inválida');
            }
        });
        $('.bt-facturar').on('click', function() {
            // Obtener datos del cliente seleccionado
            
            var direccion = $('#cliente option:selected').data('direccion');
            var telefono = $('#cliente option:selected').data('telefono');
            var correo = $('#cliente option:selected').data('correo');
            var nitCliente = $('#cliente option:selected').data('nit')
    
            // Obtener datos de la orden seleccionada
            var orden = $('#orden').val();
    
            // Obtener productos de la tabla
            var productos = [];
            $('#tabla-formulario tbody tr').each(function() {
                var idProducto = $(this).find('td:eq(0)').text();
                var nombreProducto = $(this).find('td:eq(1)').text();
                var cantidad = $(this).find('td:eq(2)').text();
                var costoUnitario = $(this).find('td:eq(3)').text();
    
                productos.push({
                    id_producto: idProducto,
                    nombre: nombreProducto,
                    cantidad: cantidad,
                    costo_unitario: costoUnitario
                });
            });
    
            // Obtener estado de los checkboxes de IVA e ICA
            var incluirIVA = $('#checkIva').prop('checked');
            var incluirICA = $('#checkIca').prop('checked');
            var factura = $('.facturaN').text();
    
            // Obtener valores de subtotal, IVA e ICA
            var subtotal = $('.ValorSubtotal').text().replace('$', '').trim();
            var iva = $('.ValorIva').text().replace('$', '').trim();
            var ica = $('.ValorIca').text().replace('$', '').trim();
            var total = $('.Ptotal').text().replace('$', '').trim();
    
            // Construir objeto con todos los datos
            var datosFacturacion = {
                factura : factura,
                cliente: nitCliente,
                direccion: direccion,
                telefono: telefono,
                correo: correo,
                orden: orden,
                productos: productos,
                incluir_iva: incluirIVA,
                incluir_ica: incluirICA,
                subtotal: subtotal,
                iva: iva,
                ica: ica,
                total: total
            };
            console.log('datos js :', datosFacturacion)
            // Realizar la solicitud AJAX para enviar los datos al servidor
            $.ajax({
                url: Facturacion,  // URL donde se procesará la solicitud en Django
                type: 'POST',  // Método de solicitud (POST según tu configuración en Django)
                headers: {
                    'Content-Type': 'application/json',
                    "X-CSRFToken": getCookie("csrftoken")
                },
                data: JSON.stringify(datosFacturacion),  // Datos a enviar al servidor
                success: function(response) {
                    // Manejar la respuesta exitosa del servidor aquí
                    console.log('Respuesta del servidor:', response);
                    // Aquí podrías mostrar un mensaje de éxito o redireccionar a otra página
                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud AJAX aquí
                    console.error('Error en la solicitud AJAX:', error);
                }
            });
        });
        
        
        
    

});

function obtenerFechaActual() {
    // Obtener la fecha y hora actuales en UTC
    var fechaActual = new Date();
    
    // Obtener el desplazamiento horario en minutos desde UTC para la zona horaria de Colombia (UTC-5)
    var offsetColombia = -5 * 60;
    
    // Calcular la fecha y hora en la zona horaria de Colombia
    var fechaColombia = new Date(fechaActual.getTime() + offsetColombia * 60 * 1000);
    
    return fechaColombia;
}


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
