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
