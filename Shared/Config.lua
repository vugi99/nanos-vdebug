
DEBUG_SHARED_EVENTS = true
DEBUG_CLIENT_EVENTS = true
DEBUG_SERVER_EVENTS = true

Show_Info_Max_Distance_sq = 6250000
Screen_Text_Font_Size = 10
Each_Text_Y_Offset = 13

VDEBUG_CLASSES = {
    Character = {
        Bases_Classes = {
            "Actor",
        },
        Get_Funcs = {
            "IsInRagdollMode",
            "IsInvulnerable",
            "IsMovementEnabled",
            "GetCameraMode",
            "GetFallingMode",
            "GetFlyingMode",
            "GetGaitMode",
            "GetGrabbedProp",
            "GetHealth",
            "GetMaxHealth",
            "GetMesh",
            "GetPicked",
            "GetPlayer",
            "GetStanceMode",
            "GetSwimmingMode",
            "GetTeam",
            "GetVehicle",
            "GetViewMode",
            "GetVelocity",
        },
        Server_Events = {
            "AttemptEnterVehicle",
            "Interact",
            "AttemptLeaveVehicle",
            "AttemptReload",
        },
        Shared_Events = {
            "Death",
            "Drop",
            "EnterVehicle",
            "FallingModeChanged",
            "Fire",
            "GaitModeChanged",
            "GrabProp",
            "Highlight",
            "LeaveVehicle",
            "MoveCompleted",
            "PickUp",
            "Possessed",
            "Punch",
            "RagdollModeChanged",
            "Reload",
            "Respawn",
            "StanceModeChanged",
            "SwimmingModeChanged",
            "TakeDamage",
            "UnGrabProp",
            "UnPossessed",
            "ViewModeChanged",
            "WeaponAimModeChanged",
        },
    },
    Player = {
        Server_Events = {
            "Ready",
        },
        Shared_Events = {
            "Destroy",
            "Possess",
            "Spawn",
            "UnPossess",
            "VOIP",
        },
    },
    Billboard = {
        Bases_Classes = {
            "Client_Only_Actor",
        },
    },
    Cable = {
        Get_Funcs = {
            "GetID",
            "GetLocation",
            "GetAttachedStartTo",
            "GetAttachedEndTo",
        },
        Shared_Events = {
            "Destroy",
            "Spawn",
            "ValueChange",
        },
    },
    Decal = {
        Bases_Classes = {
            "Client_Only_Actor",
        },
    },
    Grenade = {
        Bases_Classes = {
            "Actor",
            "Pickable",
        },
        Get_Funcs = {
            "GetBaseDamage",
            "GetDamageFalloff",
            "GetDamageInnerRadius",
            "GetDamageOuterRadius",
            "GetMinimumDamage",
            "GetTimeToExplode",
            "GetThrowForce",
        },
    },
    Light = {
        Bases_Classes = {
            "Actor",
        },
    },
    Melee = {
        Bases_Classes = {
            "Actor",
            "Pickable",
        },
        Get_Funcs = {
            "GetAnimationCharacterUse",
            "GetSoundUse",
            "GetBaseDamage",
            "GetCooldown",
        },
    },
    Particle = {
        Bases_Classes = {
            "Actor",
        },
    },
    Prop = {
        Bases_Classes = {
            "Actor",
        },
        Get_Funcs = {
            "GetAssetName",
            "GetHandler",
            "IsGrabbable",
        },
        Shared_Events = {
            "Grab",
            "Hit",
            "Interact",
            "TakeDamage",
            "UnGrab",
        },
    },
    SceneCapture = {
        Bases_Classes = {
            "Client_Only_Actor",
        },
    },
    Sound = {
        Bases_Classes = {
            "Client_Only_Actor",
        },
        Get_Funcs = {
            "IsPlaying",
            "GetDuration",
        },
    },
    StaticMesh = {
        Bases_Classes = {
            "Actor",
        },
        Get_Funcs = {
            "GetMesh",
        },
        Shared_Events = {
            "TakeDamage",
        },
    },
    TextRender = {
        Bases_Classes = {
            "Actor",
        },
    },
    Trigger = {
        Bases_Classes = {
            "Actor",
        },
        Server_Events = {
            "BeginOverlap",
            "EndOverlap",
        },
    },
    Vehicle = {
        Bases_Classes = {
            "Actor",
        },
        Get_Funcs = {
            "GetAssetName",
            --"GetPassenger",
            --"GetPassengers",
            "GetVelocity",
        },
        Shared_Events = {
            "Horn",
            "Hit",
            "CharacterEntered",
            "CharacterLeft",
        },
        Server_Events = {
            "CharacterAttemptEnter",
            "CharacterAttemptLeave",
        },
    },
    Weapon = {
        Bases_Classes = {
            "Actor",
            "Pickable",
        },
        Get_Funcs = {
            "GetAmmoBag",
            "GetAmmoClip",
        },
        Shared_Events = {
            "Fire",
            "Reload",
        },
    },
    Client = {
        Client_Events = {
            "Chat",
            "ChatEntry",
            "Console",
            --"KeyDown",
            --"KeyPress",
            --"KeyUp",
            "OpenChat",
            "CloseChat",
        }
    },
    Package = {
        Shared_Events = {
            "Load",
            "Unload",
        },
    },
    Render = {
        Client_Events = {
            "ViewportResized",
        },
    },
    Server = {
        Server_Events = {
            "Chat",
            "Console",
            "Start",
            "PlayerConnect",
            "Stop",
        },
    },
}

Base_Classes = {
    Actor = {
        Get_Funcs = {
            "GetID",
            "GetLocation",
            "GetRotation",
            "GetScale",
        },
        Shared_Events = {
            "Destroy",
            "Spawn",
            "ValueChange",
        },
    },
    Server_Only_Actor = {
        Server_Events = {
            "Destroy",
            "Spawn",
            "ValueChange",
        },
    },
    Client_Only_Actor = {
        Get_Funcs = {
            "GetID",
            "GetLocation",
            "GetRotation",
            "GetScale",
        },
        Client_Events = {
            "Destroy",
            "Spawn",
            "ValueChange",
        },
    },
    Pickable = {
        Get_Funcs = {
            "GetAssetName",
            "GetHandler",
        },
        Server_Events = {
            "Interact",
        },
        Shared_Events = {
            "Drop",
            "Hit",
            "PickUp",
            "PullUse",
            "ReleaseUse",
        },
    },
}