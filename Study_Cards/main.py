# Dev10 Data Engineering Study Flash Cards

from tkinter import PhotoImage, Tk, Canvas, Button
import pandas as pd
import random

BG_COLOR = "#B1DDC6"
TITLE_FONT = ('Ariel', 40, 'italic')
WORD_FONT = ('Ariel', 24, 'bold')

# Loading Q/A Data
q_df = pd.read_csv('Data/demoqs.csv', sep='|')
active_q = q_df.to_dict(orient='records')


# Generate Card
def new_card():
    global current_card
    current_card = random.choice(active_q)
    flash_card.itemconfig(side, image=card_front)
    flash_card.itemconfig(card_title, text='Question', fill='black')
    flash_card.itemconfig(
        card_text, text=current_card['Question'], fill='black')


# Flip Card
def flip_card():
    flash_card.itemconfig(side, image=card_back)
    flash_card.itemconfig(card_title, text='Answer', fill='white')
    flash_card.itemconfig(
        card_text,
        text=current_card['Answer'],
        fill='white'
    )


# User Interface
window = Tk()
window.title('Dev10 Interview Study Cards')
window.config(
    padx=50,
    pady=50,
    bg=BG_COLOR
)

card_back = PhotoImage(file='Images/card_back.png')
card_front = PhotoImage(file='Images/card_front.png')
right_img = PhotoImage(file='Images/right.png')
wrong_img = PhotoImage(file='Images/wrong.png')
flip_img = PhotoImage(file='Images/flip.png')

flash_card = Canvas(
    width=800,
    height=526,
    bg=BG_COLOR,
    highlightthickness=0
)

side = flash_card.create_image(400, 263, image=card_front)
card_title = flash_card.create_text(400, 90, text='', font=TITLE_FONT)
card_text = flash_card.create_text(400, 263,
                                   text='',
                                   width=750,
                                   font=WORD_FONT
                                   )
flash_card.grid(row=0, column=0, columnspan=3)

x_button = Button(
    image=wrong_img,
    borderwidth=0,
    highlightthickness=0,
    command=new_card
)
x_button.grid(row=1, column=0)

check_button = Button(
    image=right_img,
    borderwidth=0,
    highlightthickness=0,
    command=new_card
)
check_button.grid(row=1, column=1)

flip_button = Button(
    image=flip_img,
    borderwidth=0,
    highlightthickness=0,
    command=flip_card
)
flip_button.grid(row=1, column=2)

new_card()

window.mainloop()
