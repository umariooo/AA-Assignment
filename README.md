# AA-Assignment

# Nyra — The Void Jelly

## Project Overview

Nyra is a bioluminescent artificial lifeform that drifts through a dark 2D void and interacts with the player through movement, emotion, and behaviour. Nyra appears to have a mind of its own. It observes the player's mouse movements and reacts using different emotional states such as curiosity, fear, contentment, and loneliness.

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
- Soft chirps when curious
- Sharp pulse sounds when threatened
- Rhythmic tones while sleeping

Sound pitch and intensity change depending on Nyra's emotional state.
