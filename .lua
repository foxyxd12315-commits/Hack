-- Función que contiene la lógica para la Opción 1: Key
function opcion_key()
    print("\n--- Opción 1: Key seleccionada ---")
    print("Has accedido a la funcionalidad 'Key'.")
    -- Aquí iría tu lógica o llamada a otra función en Lua
    print("Generando una clave de ejemplo...")
    
    -- Ejemplo de acción en Lua:
    local clave_generada = math.random(1000, 9999) -- Genera un número aleatorio de 4 dígitos
    print("Clave generada: " .. clave_generada)
end

-- Función principal que muestra el menú y maneja la selección
function hub_principal()
    -- Bucle principal para mantener el menú
    while true do
        print("\n=========================")
        print("     🖥️ HUB PRINCIPAL 🖥️    ")
        print("=========================")
        print("1. Key")
        print("0. Salir")
        print("-------------------------")

        -- Solicitar entrada al usuario
        io.write("Elige una opción (1 o 0): ")
        local seleccion = io.read()
        
        -- Convertir la entrada a número (importante en Lua)
        local num_seleccion = tonumber(seleccion)

        if num_seleccion == 1 then
            opcion_key()
        elseif num_seleccion == 0 then
            print("\n👋 Saliendo del Hub. ¡Hasta luego!")
            break -- Sale del bucle 'while'
        else
            print("\n❌ Opción no válida. Por favor, elige '1' o '0'.")
        end
    end
end

-- Ejecutar el hub
hub_principal()
