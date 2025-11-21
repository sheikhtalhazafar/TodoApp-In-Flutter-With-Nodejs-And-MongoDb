const Usernotes = require('../nodemodel/notesmodel');

async function post_notes(req, res) {
    try {
        const usernotes = req.body.notes
        if (!usernotes) {
            return res.status(400).json({ error: 'Note content is required' });
        }
        const savedNote = new Usernotes({
            notes: usernotes
        })
        await savedNote.save();

        res.status(200).json({
            message: 'Note saved successfully',
            data: savedNote
        })

    } catch (e) {
        console.error('Error saving note:', e);
        return res.status(500).json({
            error: 'Internal Server Error',
            details: e.message
        });
    }
}



async function fetch_notes(req, res) {
    try {
        const notes = await Usernotes.find({}).lean();

        if (!notes) {
            return res.status(404).json({
                message: "No notes found",
                data: []
            });
        }
        res.status(200).json({
            message: 'Notes Fetched Successfully',
            count: notes.length,
            data: notes
        })
    } catch (e) {
        console.error('Error saving note:', e);
        return res.status(500).json({
            error: 'Internal Server Error',
            details: e.message
        });
    }
}


async function update_notes(req, res) {
    try {
        const noteId = req.params.id;
        const updatedbody = req.body.notes;
        const updatenotes = await Usernotes.findByIdAndUpdate(noteId, {
            notes: updatedbody,                     // fields to update
            new: true
        });

        if (!updatenotes) {
            return res.status(404).json({ message: 'Note not found' });
        }

        res.status(200).json({
            message: "Note updated successfully",
            data: updatenotes
        });

    } catch (e) {
        console.error("Error deleting note:", e);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

async function delete_notes(req, res) {
    try {
        const noteId = req.params.id;

        const deletedNote = await Usernotes.findByIdAndDelete(noteId);

        if (!deletedNote) {
            return res.status(404).json({ message: 'Note not found' });
        }

        res.status(200).json({
            message: "Note deleted successfully",
            data: deletedNote
        });

    } catch (e) {
        console.error("Error deleting note:", e);
        res.status(500).json({ error: "Internal Server Error" });
    }
}


module.exports = {
    post_notes,
    fetch_notes,
    update_notes,
    delete_notes
}
