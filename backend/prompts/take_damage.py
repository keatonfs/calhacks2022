# Take Damage
# This text generates battle descriptions based on the player name, enemy type and final health of the player.

prompt = """
Name: Frank
Enemy: Goblin
Health: 100
Description: Frank manages to use his stick to trap the goblin in an area he can easily hit with his heavy blow, causing the goblin to burst open into a mass of body parts. The goblin reassembles themselves.

--

Name: Matt
Enemy: Orc
Health: 75
Description: The enemy orc has struck Abhi in the stomach with the blunt edge of their arrow leaving them with a large bruise.

--

Name: Jessica
Enemy: Goblin
Health: 50
Description: A goblin used their rusty arrow to pierce through Keaton's armor, leaving him with a large surface wound on his chest.

--

Name: Varun
Enemy: Ghost
Health: 25
Description: The ghost forces a sharp spear through Varun's arm leaving him with a severe wound as he leaks blood.

--

Name: Charlie
Enemy: Demon
Health: 10
Description: A demon repeatedly strikes Charlie in the stomach with their arrow, causing him to feel a sharp pain and lose a lot of blood.

--

Name: {}
Enemy: {}
Health: {}
Description: 
"""
