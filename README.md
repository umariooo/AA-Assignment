# AA-Assignment

# Nyra — The Void Jelly

## Project Overview

Nyra is a bioluminescent artificial lifeform that drifts through a dark 3D void and interacts with the player through movement, emotion, and behaviour. Nyra appears to have a mind of its own. It observes the player's mouse movements and reacts using different emotional states such as curiosity, fear, contentment, and loneliness.

These emotional states influence Nyra's movement patterns, colour, and behaviour. Nyra's brain is implemented using a Behavior Tree architecture, allowing it to autonomously choose actions based on environmental stimuli and player interaction.

The goal of the project is to create the illusion of life by combining procedural animation, steering behaviours, and emotional state changes.

---

## Features

### Emotional State System

Nyra has several emotional states which change how it behaves and how it looks.

| Emotion | Behaviour | Visual Effect |
|-----------|-------------------------------|----------------|
| Curious | Orbits the cursor slowly | Cyan glow |
| Content | Drifts peacefully | Soft blue glow |
| Threatened | Flees from sudden movement | Purple/red glow |
| Lonely | Approaches the player slowly | Pale white glow |
| Sleeping | Pulses gently in place | Dim teal glow |

---

### Steering Behaviours

Natural movement is implemented using steering behaviours.

| Behaviour | Description |
|-----------|-------------|
| Seek | Move toward the cursor |
| Flee | Move away when startled |
| Orbit | Circle around the cursor |
| Wander | Drift randomly through the void |
| Arrive | Slow down when approaching a target |

These behaviours make Nyra's movement appear organic and lifelike.

---

### Sound Design

Sound reinforces Nyra's emotional states.

- Ambient hum while drifting
- Sharp pulse sounds when threatened

Sound pitch and intensity change depending on Nyra's emotional state.

## What I Learned

Working on this project, I learned how to implement boids into a godot project and how to use the DebugDraw addon to help with debugging.
I also learned how to improve the visualisation of a standard sphere mesh by using a custom made gdshader script, that provides a unique look to the mesh. Additionaly, I improved my understanding of GDScript and was able to effectively use new features such as the "match" statement. I also gained an understanding into how external assets can be used and implemented in a Godot project. I used Sketchfab to download free to use assets, that I used to improve the aesthetic and atmosphere of the game.


## Video Link
https://youtu.be/cT3VOYCP4PA




