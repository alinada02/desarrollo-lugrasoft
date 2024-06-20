document.addEventListener("DOMContentLoaded", function() {
    var fechaCreacionInput = document.getElementById("fechaCreacion");
    var fechaActual = obtenerFechaActual();
    var fechaFormatoISO = fechaActual.toISOString().split('T')[0];
    var addprovBtn = document.getElementById("addprov");
    var modal = document.getElementById("miModal");
    var modal2 = document.getElementById("miModal2");
    var addprod = document.getElementById("addprod");
    var form = document.getElementById("miModal").querySelector("form");
    var span = document.getElementsByClassName("close")[0];
    var span2 = document.getElementsByClassName("closemodal2")[0];
    const selectedProducts = new Set();
    const materiasPrimasRequeridas = {}; // Objeto para almacenar cantidades requeridas de materias primas
    const existenciasMateriasPrimas = {}; // Objeto para almacenar existencias de materias primas
    const tabButtons = document.querySelectorAll(".tab-button");
    const tabContents = document.querySelectorAll(".tab-content");

    function mostrarPestanaActiva() {
        // Mostrar la pestaña de la tabla por defecto
        document.getElementById("tabla-content").classList.add("active");
        document.querySelector(".tab-button[data-tab='tabla-content']").classList.add("active");
    }

    tabButtons.forEach(button => {
        button.addEventListener("click", function() {
            // Ocultar todas las pestañas y desactivar botones
            tabButtons.forEach(btn => btn.classList.remove("active"));
            tabContents.forEach(content => content.classList.remove("active"));

            // Mostrar la pestaña correspondiente al botón clickeado
            const tabId = this.getAttribute("data-tab");
            document.getElementById(tabId).classList.add("active");
            this.classList.add("active");
        });
    });

    mostrarPestanaActiva();

    fechaCreacionInput.value = fechaFormatoISO;
    fechaCreacionInput.setAttribute('readonly', 'readonly');

    $('#id_cliente').select2();
    $('#producto').select2();

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

                        // Actualizar cantidades requeridas de materias primas
                        materiasPrimas.forEach(mp => {
                            const codigoMP = mp.codigo;
                            const cantidadMP = mp.cantidad_requerida;

                            if (materiasPrimasRequeridas[codigoMP]) {
                                // Si la materia prima ya está en el registro, sumar la cantidad requerida
                                materiasPrimasRequeridas[codigoMP] += cantidadMP;
                            } else {
                                // Si no está en el registro, asignar la cantidad requerida
                                materiasPrimasRequeridas[codigoMP] = cantidadMP;
                            }

                            // Actualizar existencias de materias primas
                            existenciasMateriasPrimas[codigoMP] = mp.cantidad_actual;
                        });

                        const newRow = $('<tr>');

                        const idCell = $('<td>').text(productoId);
                        const nombreCell = $('<td>').text(productoNombre);
                        const cantidadCell = $('<td>');
                        const cantidadInput = $('<input>').attr('type', 'number').addClass('cantidad-input').val(1);
                        cantidadCell.append(cantidadInput);

                        const opcionesCell = $('<td>');
                        const deleteButton = $('<button>').text('Eliminar').addClass('delete-btn');
                        deleteButton.on('click', function() {
                            newRow.remove();
                            selectedProducts.delete(productoId);
                            $('#producto option[value="' + productoId + '"]').prop('disabled', false);
                            updateInfoContainers(); // Actualizar al eliminar producto
                        });
                        opcionesCell.append(deleteButton);

                        newRow.append(idCell, nombreCell, cantidadCell, opcionesCell).attr('data-producto-id', productoId);

                        $('#tabla-formulario tbody').append(newRow);
                        updateInfoContainers();

                        $('#producto option[value="' + productoId + '"]').prop('disabled', true);
                        $('#producto').val(null).trigger('change');

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

        // Actualizar el contenedor de existencias con las materias primas del producto seleccionado
        $('#existencias-inventario').html(obtenerExistenciasHtml(productoId));
    });

    // Añade evento de cambio de entrada para las cantidades en la tabla
    $('#tabla-formulario').on('input', '.cantidad-input', function() {
        updateInfoContainers();
    });

    function updateInfoContainers() {
        // Reiniciar el objeto de cantidades requeridas de materias primas
        const materiasPrimasRequeridas = {};

        // Iterar sobre todas las filas de la tabla
        $('#tabla-formulario tbody tr').each(function() {
            const productoId = $(this).data('productoId');
            const cantidad = $(this).find('.cantidad-input').val() || 1; // Si no hay cantidad, se asume 1

            // Actualizar cantidades requeridas de materias primas para este producto
            $.ajax({
                url: materiasprimas, // Asegúrate de que esta URL coincide con tu configuración de Django
                data: { producto_id: productoId },
                async: false, // Hacer la solicitud de manera sincrónica para garantizar el orden de ejecución
                success: function(response) {
                    if (response.success) {
                        const materiasPrimas = response.materias_primas;

                        materiasPrimas.forEach(mp => {
                            const codigoMP = mp.codigo;
                            const cantidadRequerida = mp.cantidad_requerida * cantidad;

                            if (materiasPrimasRequeridas[codigoMP]) {
                                // Si la materia prima ya está en el registro, sumar la cantidad requerida
                                materiasPrimasRequeridas[codigoMP] += cantidadRequerida;
                            } else {
                                // Si no está en el registro, asignar la cantidad requerida
                                materiasPrimasRequeridas[codigoMP] = cantidadRequerida;
                            }
                        });

                    } else {
                        alert('Error: ' + response.error);
                    }
                },
                error: function() {
                    alert('Error al validar el producto.');
                }
            });
        });

        actualizarVisualizacionMateriasPrimasRequeridas(materiasPrimasRequeridas);
    }

    function actualizarVisualizacionMateriasPrimasRequeridas(materiasPrimasRequeridas) {
        const tableBody = $('#materias-primas-table tbody');
        tableBody.empty(); // Limpiar filas existentes
    
        Object.keys(materiasPrimasRequeridas).forEach(codigoMP => {
            const cantidadRequerida = materiasPrimasRequeridas[codigoMP];
            const cantidadEnInventario = existenciasMateriasPrimas[codigoMP] || 'No disponible';
    
            const rowHtml = `<tr><td>${codigoMP}</td><td>${cantidadRequerida}</td><td>${cantidadEnInventario}</td></tr>`;
            tableBody.append(rowHtml);
        });
    }
    
    function obtenerExistenciasHtml(productoId) {
        let existenciasHtml = '';

        // Obtener las materias primas para el producto actual
        $.ajax({
            url: materiasprimas, // Asegúrate de que esta URL coincide con tu configuración de Django
            data: { producto_id: productoId },
            async: false, // Hacer la solicitud de manera sincrónica para garantizar el orden de ejecución
            success: function(response) {
                if (response.success) {
                    const materiasPrimas = response.materias_primas;

                    materiasPrimas.forEach(mp => {
                        existenciasHtml += `<p>${mp.nombre} (Código: ${mp.codigo}) - Cantidad en Inventario: ${mp.cantidad_actual}</p>`;
                        
                        // Actualizar existencias de materias primas en el objeto global
                        existenciasMateriasPrimas[mp.codigo] = mp.cantidad_actual;
                    });

                } else {
                    alert('Error: ' + response.error);
                }
            },
            error: function() {
                alert('Error al validar el producto.');
            }
        });

        return existenciasHtml;
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
    };

    addprod.onclick = function() {
        modal2.style.display = "block";
    };

    // Cuando el usuario haga clic en <span> (x), cerrar la ventana modal
    span.onclick = function() {
        modal.style.display = "none";
    };

    span2.onclick = function() {
        modal2.style.display = "none";
    };

    // Cuando el usuario haga clic fuera del contenido de la ventana modal, cerrarla
    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
        if (event.target == modal2) {
            modal2.style.display = "none";
        }
    };

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
