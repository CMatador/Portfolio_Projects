# Dev10 Data Engineering Study Flash Cards

from tkinter import PhotoImage, Tk, Canvas, Button
import pandas as pd
import random

BG_COLOR = "#2E8A99"
TITLE_FONT = ('Ariel', 40, 'italic')
Q_FONT = ('Ariel', 18, 'bold')
A_FONT = ('Ariel', 14, 'bold')
MODULELIST = 'Data/ModuleSelectionMenu.txt'


# Takes user input for question subset
def topic_selection():
    topic = input('Which of the following topics would you like to study? Please type only the topic number. ') # noqa
    while not topic.isnumeric():
        topic = input(
            'Your response is not a valid number. Please enter a topic number. ') # noqa
    while not (0 < int(topic) <= 6):
        topic = input('The topic number you chose is invalid. Please choose an appropriate topic number. ') # noqa
    print(f'You have chosen {module_list[int(topic)]}.')
    return int(topic)


# Generate Card
def new_card():
    global current_card
    try:
        current_card = random.choice(active_q)
        flash_card.itemconfig(side, image=card_front)
        flash_card.itemconfig(card_title, text='Question', fill='black')
        flash_card.itemconfig(
            card_text, text=current_card['Questions'], fill='black')
        flash_card.itemconfig(
            bottom_text,
            text=''
        )
    except IndexError:
        flash_card.itemconfig(
            card_title,
            text='Congratulations!',
            fill='black'
            )
        flash_card.itemconfig(
            card_text,
            text='You have finished all of the questions.',
            fill='black'
        )
        flash_card.itemconfig(
            bottom_text,
            text=''
        )
        flip_button['state'] = 'disabled'
        check_button['state'] = 'disabled'
        x_button['state'] = 'disabled'


# Flip Card
def flip_card():
    flash_card.itemconfig(side, image=card_back)
    flash_card.itemconfig(card_title, text='Answer', fill='black')
    flash_card.itemconfig(
        card_text,
        text=current_card['Questions'],
        fill='black'
    )
    flash_card.itemconfig(
        bottom_text,
        text=current_card['Answers'],
        fill='black'
    )


# Remove Cards
def remove_card():
    active_q.remove(current_card)
    new_card()


# Pick which topics we want
module_list = []

with open(MODULELIST, 'r') as file:
    for line in file.readlines():
        module_list.append(line.replace('\n', ''))
        print(line)

selection = topic_selection()

# Loading Q/A Data
q_df = pd.read_csv('Data/interview_qa.csv', sep='~')

if selection == 1:
    q_subset = q_df.loc[q_df['Module'].str.contains('Module 1', case=False)]
elif selection == 2:
    q_subset = q_df.loc[q_df['Module'].str.contains('Module 2|Module 3', case=False)] # noqa
elif selection == 3:
    q_subset = q_df.loc[q_df['Module'].str.contains('Module 4|Module 8', case=False)] # noqa
elif selection == 4:
    q_subset = q_df.loc[q_df['Module'].str.contains('Module 6|Module 7', case=False)] # noqa
elif selection == 5:
    q_subset = q_df.loc[q_df['Module'].str.contains('Module 9|Modules 10|General', case=False)] # noqa
elif selection == 6:
    q_subset = q_df

active_q = q_subset.to_dict(orient='records')

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
card_title = flash_card.create_text(400, 90,
                                    text='',
                                    font=TITLE_FONT
                                    )
card_text = flash_card.create_text(400, 180,
                                   text='',
                                   width=750,
                                   font=Q_FONT
                                   )
bottom_text = flash_card.create_text(400, 350,
                                     text='',
                                     width=750,
                                     font=A_FONT
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
    command=remove_card
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
