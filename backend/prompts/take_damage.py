# Take Damage
# This text generates battle descriptions based on the player name, enemy type and final health of the player.

prompt = """
Name: Matt
Enemy: Orc
Health: 75
Description: The enemy orc has struck Abhi in the stomach with the blunt edge of their blade leaving them with a large bruise.

--

Name: Jessica
Enemy: Goblin
Health: 50
Description: A goblin used their rusty blade to pierce through Keaton's armor, leaving him with a large surface wound on his chest.

--

Name: Varun
Enemy: Ghost
Health: 25
Description: The ghost forces a sharp blade through Varun's arm leaving him with a severe wound as he leaks blood.

--

Name: {}
Enemy: {}
Health: {}
Description: 
"""
