document.addEventListener('DOMContentLoaded', function(){
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
    function cargarMateriasPrimasPorProducto(codInventario, cantidad) {
        if (!codInventario || cantidad <= 0) {
            console.error('Parámetros inválidos para cargar materias primas por producto.');
            return;
        }
    
        var tbodyMateriasPrimas = document.getElementById('materias-primas-table').getElementsByTagName('tbody')[0];
    
        $.ajax({
            url: VerMateriasPrimas,
            type: 'GET',
            data: {
                producto_id: codInventario
            },
            success: function(response) {
                if (response.success) {
                    var materiasPrimas = response.materias_primas;
    
                    materiasPrimas.forEach(function(materiaPrima) {
                        // Multiplicar la cantidad requerida por la cantidad del producto
                        var cantidadRequeridaTotal = materiaPrima.cantidad_requerida * cantidad;
    
                        // Buscar la materia prima en la tabla
                        var existingRow = encontrarFilaExistente(tbodyMateriasPrimas, materiaPrima.codigo);
    
                        if (existingRow) {
                            // Si la fila ya existe, sumar las cantidades requeridas
                            var cantidadRequeridaActual = parseFloat(existingRow.cells[2].innerHTML);
                            var nuevaCantidadRequerida = cantidadRequeridaActual + cantidadRequeridaTotal;
                            existingRow.cells[2].innerHTML = nuevaCantidadRequerida.toFixed(2);
                        } else {
                            // Si la fila no existe, agregar una nueva fila
                            var row = tbodyMateriasPrimas.insertRow();
                            var cellCodigo = row.insertCell(0);
                            var cellNombre = row.insertCell(1);
                            var cellCantidadRequerida = row.insertCell(2);
                            var cellCantidadActual = row.insertCell(3);
    
                            cellCodigo.innerHTML = materiaPrima.codigo;
                            cellNombre.innerHTML = materiaPrima.nombre;
                            cellCantidadRequerida.innerHTML = cantidadRequeridaTotal.toFixed(2); // Mostrar la cantidad total requerida
                            cellCantidadActual.innerHTML = materiaPrima.cantidad_actual;
                        }
                    });
                } else {
                    console.error('Error al obtener las materias primas:', response.error);
                }
            },
            error: function(xhr, status, error) {
                console.error('Error en la solicitud AJAX:', status, error);
            }
        });
    }
    
    function encontrarFilaExistente(tbody, codigo) {
        for (var i = 0; i < tbody.rows.length; i++) {
            var row = tbody.rows[i];
            if (row.cells[0].innerHTML === codigo) {
                return row;
            }
        }
        return null;
    }
    
    
    
    
    
    mostrarPestanaActiva();

    $(document).ready(function() {
        // Abrir modal y cargar detalles al hacer clic en una fila de la tabla
        function limpiarTablaMateriasPrimas() {
            var tbodyMateriasPrimas = document.getElementById('materias-primas-table').getElementsByTagName('tbody')[0];
            tbodyMateriasPrimas.innerHTML = ''; // Limpiar el cuerpo de la tabla
        }
        $('.open-modal').on('click', function(event) {
            event.preventDefault();
            var idOrden = $(this).data('id');
            $('#modalDetalleOrden').show();

            limpiarTablaMateriasPrimas();

             // Obtener la tabla de detalles y limpiar el cuerpo de la tabla
            var tbodyDetalles = document.getElementById('tabla-detalles').getElementsByTagName('tbody')[0];
            tbodyDetalles.innerHTML = '';

            $.ajax({
                url: DetalleOrden.replace('0', idOrden),
                type: 'GET',
                success: function(response) {
                    // Manejar la respuesta del backend y mostrar los elementos en la tabla modal
                    var detalles = response.detalles;
                    var tbody = document.getElementById('tabla-detalles').getElementsByTagName('tbody')[0];
                    tbody.innerHTML = ''; // Limpiar el cuerpo de la tabla

                    detalles.forEach(function(detalle) {
                        var row = tbody.insertRow();
                        var cellProducto = row.insertCell(0);
                        var cellNombre = row.insertCell(1);
                        var cellCantidad = row.insertCell(2);

                        cellProducto.innerHTML = detalle.cod_inventario;
                        cellNombre.innerHTML = detalle.nombre;
                        cellCantidad.innerHTML = detalle.cantidad;
                        // Agrega más celdas según sea necesario

                        // Llamar a la función para cargar las materias primas de este producto
                        cargarMateriasPrimasPorProducto(detalle.cod_inventario, detalle.cantidad);
                    });

                    // Aquí puedes hacer lo que necesites con el ID de compra, como mostrarlo en el modal
                    console.log("ID de compra:", idOrden);

                    // Mostrar el modal
                    modalDetalleOrden.style.display = 'block';
                },
                error: function(xhr, status, error) {
                    // Manejar errores de la solicitud AJAX
                    console.error(xhr.responseText);
                }
            });

            // Cerrar modal al hacer clic en el botón de cerrar (×)
            $('.close').on('click', function() {
                $('#modalDetalleOrden').hide();
            });
        
            // Cerrar modal al hacer clic fuera de él
            $(window).on('click', function(event) {
                if (event.target == $('#modalDetalleOrden')[0]) {
                    $('#modalDetalleOrden').hide();
                }
            });
        });
    });

});