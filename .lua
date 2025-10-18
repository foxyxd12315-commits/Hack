local CONTRASENA_CORRECTA = "YO NO JUI"
local URL_KEY = "https://scriiipt-roblox-hack-steelabrainroot.blogspot.com/2025/10/script-y-key-aqui.html"
local hub_abierto = false

-- Servicios necesarios
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

-- 1. MODIFICACIÓN CRÍTICA: Esperar al LocalPlayer
-- Esto asegura que el script no falle si se ejecuta demasiado pronto.
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    -- Si LocalPlayer es nil (lo que no debería pasar en la mayoría de los ejecutores, pero es buena práctica)
    -- Esperamos un breve momento o simplemente retornamos si el entorno es hostil.
    repeat task.wait() until Players.LocalPlayer
    LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then return end -- Si todavía no existe, el script termina aquí.
end

-- Esperamos explícitamente por el PlayerGui
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 2. FUNCIÓN PARA CREAR LA INTERFAZ VISUAL (Sin cambios en el diseño, solo la ejecución)
local function crearHubUI()
    -- ********** ESTRUCTURA PRINCIPAL **********
    local Hub = Instance.new("Frame")
    Hub.Name = "Hub_by_Foxming"
    Hub.Parent = PlayerGui -- FORZADO A PLAYERGUI
    
    -- Propiedades de diseño del Hub
    Hub.Size = UDim2.new(0.3, 0, 0.5, 0) 
    Hub.AnchorPoint = Vector2.new(0.5, 0.5)
    Hub.Position = UDim2.new(0.5, 0, 0.5, 0) 
    Hub.BackgroundColor3 = Color3.new(0, 0, 0) 
    Hub.BorderSizePixel = 4
    Hub.Active = true 
    Hub.ZIndex = 10 
    Hub.Visible = false 
    
    -- Borde redondeado (UICorner)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8) 
    Corner.Parent = Hub

    -- ********** CONTROLES (Título, Entrada, Layout) **********
    local Titulo = Instance.new("TextLabel")
    Titulo.Name = "Titulo"
    Titulo.Text = "Hub by Foxming"
    Titulo.Parent = Hub
    Titulo.Size = UDim2.new(1, 0, 0.15, 0)
    Titulo.TextColor3 = Color3.new(1, 1, 1)
    Titulo.BackgroundTransparency = 1
    
    local Entrada = Instance.new("TextBox")
    Entrada.Name = "KeyInput"
    Entrada.PlaceholderText = "Introduce la contraseña..."
    Entrada.Parent = Hub
    Entrada.Size = UDim2.new(0.8, 0, 0.1, 0)
    Entrada.Position = UDim2.new(0.1, 0, 0.2, 0)
    Entrada.TextScaled = true
    Entrada.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    Entrada.Text = "" 

    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Name = "Options"
    ButtonContainer.Parent = Hub
    ButtonContainer.Size = UDim2.new(1, 0, 0.5, 0)
    ButtonContainer.Position = UDim2.new(0, 0, 0.35, 0)
    ButtonContainer.BackgroundTransparency = 1

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Parent = ButtonContainer
    ListLayout.FillDirection = Enum.FillDirection.Vertical
    ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    ListLayout.Padding = UDim.new(0, 10)

    -- ********** CREACIÓN DE BOTONES **********
    local function crearBoton(nombre, texto)
        local Btn = Instance.new("TextButton")
        Btn.Name = nombre
        Btn.Text = texto
        Btn.Parent = ButtonContainer
        Btn.Size = UDim2.new(0.9, 0, 0.25, 0)
        Btn.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        Btn.TextColor3 = Color3.new(1, 1, 1)
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
        return Btn
    end

    local Btn_Entrar = crearBoton("Btn_Entrar", "Opcion uno (Entrar)")
    local Btn_Key = crearBoton("Btn_Key", "Opcion dos (Key)")
    local Btn_Abrir = crearBoton("Btn_Abrir", "Opcion tres (Abrir)")

    -- ********** EFECTO RAINBOW EN EL BORDE **********
    -- Usamos task.spawn para no bloquear la ejecución si el RunService falla
    local function rainbowBorder(uiElement)
        task.spawn(function()
            local hue = 0
            while uiElement.Parent do -- Bucle para correr mientras el elemento exista
                hue = hue + 0.02
                if hue >= 1 then
                    hue = 0
                end
                uiElement.BorderColor3 = Color3.fromHSV(hue, 1, 1)
                RunService.RenderStepped:Wait() -- Espera al siguiente frame de renderizado
            end
        end)
    end
    rainbowBorder(Hub) 

    -- ********** LÓGICA DE EVENTOS **********

    -- Opción uno (Entrar) - Verifica la contraseña
    Btn_Entrar.MouseButton1Click:Connect(function()
        if Entrada.Text == CONTRASENA_CORRECTA then
            hub_abierto = true
            Hub.Visible = true
            Entrada.Visible = false 
            Btn_Entrar.Visible = false 
            print("✅ Hub abierto. Contraseña correcta.")
        else
            print("❌ Contraseña incorrecta. Inténtalo de nuevo.")
        end
    end)
    
    -- Opción dos (Key) - REDIRECCIÓN DE URL (Envuelto en pcall para manejar fallas)
    Btn_Key.MouseButton1Click:Connect(function()
        if hub_abierto then
            local success, err = pcall(function()
                -- Redirección al enlace. Notar que OpenBrowserWindow puede estar desactivado/parcheado.
                GuiService:OpenBrowserWindow(URL_KEY)
            end)
            if success then
                print("🌐 Abriendo URL para obtener la Key: " .. URL_KEY)
            else
                warn("🌐 No se pudo abrir el navegador. Error: " .. err)
            end
        else
            warn("Hub bloqueado. Introduce la contraseña primero.")
        end
    end)

    -- Opción tres (Abrir/Cerrar) - Toggle
    Btn_Abrir.MouseButton1Click:Connect(function()
        if hub_abierto then
            Hub.Visible = not Hub.Visible
        else
            warn("Hub bloqueado. Introduce la contraseña primero.")
        end
    end)

    return Hub
end

-- 3. MODIFICACIÓN FINAL: Ejecutar en pcall para capturar errores de ejecución
local success, result = pcall(crearHubUI)

if success then
    print("🚀 Script Hub by Foxming cargado correctamente.")
else
    warn("❌ Error CRÍTICO al cargar el Hub: " .. result)
end
        end
    end)

    return Hub
end

-- Ejecutar la función
crearHubUI()
