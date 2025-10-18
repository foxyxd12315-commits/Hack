local CONTRASENA_CORRECTA = "YO NO JUI"
local URL_KEY = "https://scriiipt-roblox-hack-steelabrainroot.blogspot.com/2025/10/script-y-key-aqui.html?m=1"                                                                                  
local hub_abierto = false

-- Servicios necesarios
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")

-- Esperar al LocalPlayer
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    repeat task.wait() until Players.LocalPlayer
    LocalPlayer = Players.LocalPlayer
end

-- Esperar por el PlayerGui
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Función para crear la interfaz visual
local function crearHubUI()
    -- Crea la interfaz visual aquí...
    local Hub = Instance.new("Frame")
    Hub.Name = "Hub_by_Foxming"
    Hub.Parent = PlayerGui
    Hub.Size = UDim2.new(0.3, 0, 0.5, 0)
    Hub.AnchorPoint = Vector2.new(0.5, 0.5)
    Hub.Position = UDim2.new(0.5, 0, 0.5, 0)
    Hub.BackgroundColor3 = Color3.new(0, 0, 0)
    Hub.BorderSizePixel = 4
    Hub.Active = true
    Hub.ZIndex = 10
    Hub.Visible = false -- Inicialmente invisible hasta que se intente abrir o desbloquear

    -- Resto del código...
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

    -- Lógica de eventos
    Btn_Entrar.MouseButton1Click:Connect(function()
        if Entrada.Text == CONTRASENA_CORRECTA then
            hub_abierto = true
            Hub.Visible = true
            Entrada.Visible = false
            Btn_Entrar.Visible = false
            print("Hub abierto. Contraseña correcta.")
        else
            print("Contraseña incorrecta. Inténtalo de nuevo.")
        end
    end)

    Btn_Key.MouseButton1Click:Connect(function()
        if hub_abierto then
            local success, err = pcall(function()
                -- En Roblox, solo se puede abrir el navegador en juegos publicados
                GuiService:OpenBrowserWindow(URL_KEY) 
            end)
            if success then
                print("Abriendo URL para obtener la Key: " .. URL_KEY)
            else
                warn("No se pudo abrir el navegador. Error: " .. err)
            end
        else
            -- Si el hub no está abierto, se dirige al usuario a conseguir la key
            local success, err = pcall(function()
                GuiService:OpenBrowserWindow(URL_KEY)
            end)
            if success then
                print("Hub bloqueado. Abriendo URL para obtener la Key: " .. URL_KEY)
            else
                warn("Hub bloqueado y no se pudo abrir el navegador. Error: " .. err)
            end
        end
    end)

    Btn_Abrir.MouseButton1Click:Connect(function()
        if hub_abierto then
            Hub.Visible = not Hub.Visible
        else
            warn("Hub bloqueado. Introduce la contraseña primero.")
        end
    end)

    return Hub -- Es fundamental que la función devuelva la instancia del Hub
end

-- Ejecutar en pcall para capturar errores
local success, HubInstance = pcall(crearHubUI)

-- Lógica para la inicialización
if success and HubInstance then
    -- Hacemos la ventana visible inicialmente para que el usuario pueda interactuar con el input
    HubInstance.Visible = true 
    print("Hub cargado y listo para autenticación.")
elseif success == false then
    warn("Error grave al crear el Hub UI. Mensaje: " .. tostring(HubInstance))
else
    warn("La función no devolvió una instancia de Hub.")
end
