# Log

```python
def LogReport(step):
    """
        writes the report in log
    """
    ExtAPI.Log.WriteMessage("Report:")
    for s in step.Wizard.Steps.Values:
        ExtAPI.Log.WriteMessage("Step "+s.Caption)
        for prop in s.AllProperties:
            ExtAPI.Log.WriteMessage(prop.Caption+": "+prop.DisplayString)
```
