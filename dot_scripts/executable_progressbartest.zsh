
#!/bin/zsh

ICON=~/assets/kitty.png  # Replace with the path to your icon file
TITLE="Task Progress"
MESSAGE="Completing task..."
DURATION=5  # Duration in seconds
STEPS=100   # Total progress steps

# Loop to update the progress bar
for i in $(seq 0 $STEPS); do
    notify-send "$TITLE" "$MESSAGE" -i $ICON --hint=int:value:$i
    sleep $(echo "scale=2; $DURATION / $STEPS" | bc)  # Sleep for a fraction of the total duration
done
