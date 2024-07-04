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
                    // Limpiar el selector de órdenes
                    $('#orden').empty();
                    $('#orden').append('<option value=""># Orden</option>'); // Opción por defecto
    
                    // Iterar sobre las órdenes recibidas y añadirlas al selector
                    response.ordenes.forEach(function(orden) {
                        $('#orden').append('<option value="' + orden.id + '">' + orden.numero + '</option>');
                    });
    
                },
                error: function(xhr, status, error) {
                    console.error('Error al cargar las órdenes:', error);
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
