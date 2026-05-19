from renderer import render

def letter(letter, a_capo=True):
    if a_capo:
        render(letter)
    else:
        render(letter, end="")