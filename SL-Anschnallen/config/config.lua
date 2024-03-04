Config_Anschnallen = {}

Config_Anschnallen.Settings = {
    ['toggleCommand'] = 'toggleanschnallen',
    ['anschnallTaste'] = 'k',
    ['fixedWhileBuckled'] = true,
    ['ejectVelocity'] = (200 / 3.6),
    ['unknownEjectVelocity'] = (250 / 3.6),
    ['unknownModifier'] = 80.0,
    ['minDamage'] = 2000
}

Config_Anschnallen.AnschnallNotify = function()
    TriggerEvent('HIER DIE NOTIFY', 'success', 'Anschnallen', 'Du hast dich angeschnallt!')
end

Config_Anschnallen.AbschnallNotify = function()
    TriggerEvent('HIER DIE NOTIFY', 'error', 'Anschnallen', 'Du hast dich abgeschnallt!')
end