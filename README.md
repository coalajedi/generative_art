# Generative Art

Inspired by Vera Molnar’s artistic style and ideas, this project go over some basic principles of generative art by
exploring Flutter’s CustomPainter and the Canvas API, and introduce animations to make the artwork come to life.

## Who?

Vera Molnar, a great Hungarian artist based in France who is now in her 90’s and still produces work. She is considered
one of the pioneers of computer generated generative art.

From a young age, Molnar was fascinated by randomness and was one of the early adapters of using algorithms to render
artwork, and in a time when computer generated art was claimed to be dehumanized and its authenticity highly doubted,
she argued that working with the randomness in machines and their ability to efficiently produce a high number of
outputs was in fact proof of the opposite of those arguments.

Because when you work with a computer, you’re using it as a tool to achieve a closer alignment with your own
imagination. You are using your creativity and curiosity and expressing yourself in a medium that gives you more space
for exploration than manual labor could ever provide.

Over the years, Molnar’s methods and equipment for producing generative artwork kept evolving. In fact, as early as a
decade before she even had access to a computer, she was already creating “generative” art.

By definition, generative art is any practice where the artist uses a system, such as a set of natural language rules, a
computer program, or a machine, and then sets it into motion with some degree of autonomy.

In the 50s, she introduced us to the term “Machine Imaginere” or the imaginary machine. She used fundamental principles
from mathematics along with analog ‘randomness generators’ such as a roll of dice. In this way, she ‘produced’ sequences
of drawings, making modifications to a single parameter at a time. She would then meticulously handcraft each of these
variations.

After she gained access to computers, she initially worked with IBM mainframes that didn’t even have monitors. As she
transitioned to more advanced systems, she used programming languages like BASIC and Fortran to feed the machine with
specific instructions that would control a connected pen plotter. The pen plotter would then use an ink pen and a robot
arm to translate the code into drawings.

## Generative Art Tools

There are a couple of tools involved when it comes to creating generative artwork, and I want to briefly mention some
of those tools implemented with the Canvas API.

## Tiling - Generative Art Tool #1

Like tiling a wall, you tile pieces of your artwork by repeating them horizontally and vertically. We do that by
calculating the number of shapes (square in this case) that can fit horizontally and vertically in the Widget that
contains the `CustomPainter`, and draw the shapes using a simple `for` loop.

Result:

https://github.com/coalajedi/generative_art/assets/42309863/06297123-80f2-4289-bd3e-f7bf2dc9bb81

## Recursion - Generative Art Tool #2
Using the programming power of recursion to create artwork elements that can appear repeatedly nested until one or more 
conditions are met, gives endless possibilities for manipulating lines and shapes in your canvas. For our grid of 
squares, were implemented recursion in a way that is inspired by one of Ver Molnar's artworks.

The result so far:
<img width="1129" alt="Recursively drawn squares — Recursion as a generative art tool #2" src="https://github.com/coalajedi/generative_art/assets/42309863/5b48fbde-b7f5-4a31-b5a7-310feeae3edd">

## Randomness - Generative Art Tool #3
This wouldn’t be a work inspired by Vera Molnar if it did not include what fascinated her the most, randomness, which is actually a powerful tool that can result in truly mesmerizing outcomes.

We can introduce randomness here in a couple of ways:
- Randomizing the side length of the next square in the recursive function.
- Introducing a randomized depth value that would eventually randomize the size of the smallest square.

The outcome:
<img width="1386" alt="Recursively drawn square with randomization — Randomness as a generative art tool #3" src="https://github.com/coalajedi/generative_art/assets/42309863/0fef8ff2-3f1d-401a-9c8c-780f24e38e08">

## Displacement - Generative Art Tool #4
When it comes to generative art, chaos is a good thing! And we can throw some chaos at the Artwork by utilizing another useful tool, _displacement_.

For example, going back to our original square, I can say that I want to displace each corner from its original place by _randomized_ distance to create a randomized polygon.
This way combining displacement with randomness for yet a deeper level of chaos.

Using the Widgetbook package we can experiment with `maxCornerOffset` input and see how the polygon gets more distorted as this value increases and vice versa.

https://github.com/coalajedi/generative_art/assets/42309863/2b355161-1e9d-44c1-ab09-b55f2956174d

## Repetition - Generative Art Tool #5
As a final tool in our generative art tool belt, we can implement some repetition simply by using a `for` loop with `min` and `max` values that we can provide as input parameters to the system.

https://github.com/coalajedi/generative_art/assets/42309863/46327a44-8072-475a-8b2f-4b52cd4355dc

## Run the project

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Once you have the Flutter environment settled up. Clone this repo by:

```shell
git clone https://github.com/coalajedi/generative_art.git
```
