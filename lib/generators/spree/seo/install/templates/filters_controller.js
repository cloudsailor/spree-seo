import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [
        "addBtn",
        "rowsContainer",
        "template",
        "hiddenField"
    ]

    connect() {
        // On initial load
        this.loadExisting()
        // Also ensure we serialize before any form submit
        this._bindFormSubmit()
    }

    //─────────────────────────────────────────────────────
    // Utility: initialize Select2 if available
    //─────────────────────────────────────────────────────
    initSelect2(selectEl) {
        if (window.jQuery && typeof window.jQuery(selectEl).select2 === "function") {
            window.jQuery(selectEl).select2({
                width: "200px",
                placeholder: "Select values…"
            })
        }
    }

    //─────────────────────────────────────────────────────
    // 1) serializeAll(): read each .filter-row and rebuild hidden field
    //─────────────────────────────────────────────────────
    serializeAll() {
        const rows = Array.from(this.rowsContainerTarget.querySelectorAll(".filter-row"))
        if (rows.length === 0) return

        const parts = rows.map(rowDiv => {
            const idx = rowDiv.dataset.rowId
            const keyEl = rowDiv.querySelector(`#filter_key_${idx}`)
            const valSelect = rowDiv.querySelector(`#filter_values_${idx}`)
            if (!keyEl || !valSelect) return null

            const key = keyEl.value
            let vals = []

            // (a) Try reading Select2’s rendered <li title="…">
            const next = valSelect.nextElementSibling
            if (next) {
                const li = next.querySelectorAll("li[title]")
                vals = Array.from(li).map(li => li.title)
            }
            // (b) Fallback to native select
            if (vals.length === 0) {
                vals = Array.from(valSelect.selectedOptions).map(o => o.value).filter(v => v)
            }
            if (!key || vals.length === 0) return null

            return `${key}=${vals.join("|")}`
        }).filter(x => x !== null)

        this.hiddenFieldTarget.value = parts.join(";")
    }

    //─────────────────────────────────────────────────────
    // 2) keyChanged: when KEY select changes → rebuild VALUES
    //─────────────────────────────────────────────────────
    keyChanged(event) {
        const idx = event.target.dataset.idx
        const select = this.element.querySelector(`#filter_values_${idx}`)
        if (!select) return

        const opts = window.filterOptionsByKey?.[event.target.value] || []
        select.innerHTML = ""
        opts.forEach(val => {
            const opt = document.createElement("option")
            opt.value = val
            opt.textContent = val
            select.appendChild(opt)
        })

        // re-init Select2 on that select
        if (window.jQuery && typeof window.jQuery(select).select2 === "function") {
            window.jQuery(select).off("select2:select select2:unselect")
            window.jQuery(select).select2("destroy")
            this.initSelect2(select)
            window.jQuery(select)
                .on("select2:select select2:unselect", () => this.serializeAll())
        }

        this.serializeAll()
    }

    //─────────────────────────────────────────────────────
    // 3) getNextIndex(): highest data-row-id + 1 (or 0)
    //─────────────────────────────────────────────────────
    getNextIndex() {
        const existing = Array.from(this.rowsContainerTarget.querySelectorAll(".filter-row"))
        if (existing.length === 0) return 0
        const max = existing
            .map(el => parseInt(el.dataset.rowId, 10))
            .reduce((a,b) => Math.max(a,b), -1)
        return max + 1
    }

    //─────────────────────────────────────────────────────
    // 4) addRow(): clone, wire up, append, serialize
    //─────────────────────────────────────────────────────
    addRow(event) {
        event.preventDefault()
        const idx = this.getNextIndex()
        const html = this.templateTarget.innerHTML.replace(/__INDEX__/g, idx)
        const wrapper = document.createElement("div")
        wrapper.innerHTML = html
        const rowDiv = wrapper.firstElementChild
        rowDiv.classList.add("filter-row")
        rowDiv.dataset.rowId = idx

        // (a) KEY select → keyChanged
        const keySel = rowDiv.querySelector(`#filter_key_${idx}`)
        if (keySel) {
            keySel.dataset.idx = idx
            keySel.addEventListener("change", e => this.keyChanged(e))
        }

        // (b) VALUES select → init + serialize on change
        const valSel = rowDiv.querySelector(`#filter_values_${idx}`)
        if (valSel) {
            this.initSelect2(valSel)
            valSel.addEventListener("change", () => this.serializeAll())
            if (window.jQuery && typeof window.jQuery(valSel).select2 === "function") {
                window.jQuery(valSel)
                    .on("select2:select select2:unselect", () => this.serializeAll())
            }
        }

        // (c) Remove button → remove + serialize
        const rem = rowDiv.querySelector(".remove-filter-btn")
        if (rem) {
            rem.addEventListener("click", ev => {
                ev.preventDefault()
                rowDiv.remove()
                this.serializeAll()
            })
        }

        this.rowsContainerTarget.appendChild(rowDiv)
        this.serializeAll()
    }

    //─────────────────────────────────────────────────────
    // 5) loadExisting(): if hiddenField has a value, rebuild rows
    //─────────────────────────────────────────────────────
    loadExisting() {
        if (this.rowsContainerTarget.querySelector(".filter-row")) return
        const existing = this.hiddenFieldTarget.value.trim()
        if (!existing) return

        existing.split(";").forEach(pair => {
            const [key, vals] = pair.split("=")
            if (!key || !vals) return
            const idx = this.getNextIndex()
            const html = this.templateTarget.innerHTML.replace(/__INDEX__/g, idx)
            const wrapper = document.createElement("div")
            wrapper.innerHTML = html
            const rowDiv = wrapper.firstElementChild
            rowDiv.classList.add("filter-row")
            rowDiv.dataset.rowId = idx

            // set key
            const keySel = rowDiv.querySelector(`#filter_key_${idx}`)
            if (keySel) keySel.value = key

            // set values
            const valSel = rowDiv.querySelector(`#filter_values_${idx}`)
            if (valSel) {
                const opts = window.filterOptionsByKey?.[key] || []
                valSel.innerHTML = ""
                opts.forEach(val => {
                    const opt = document.createElement("option")
                    opt.value = val
                    opt.textContent = val
                    if (vals.split("|").includes(val)) opt.selected = true
                    valSel.appendChild(opt)
                })
                this.initSelect2(valSel)
                valSel.addEventListener("change", () => this.serializeAll())
                if (window.jQuery && typeof window.jQuery(valSel).select2 === "function") {
                    window.jQuery(valSel)
                        .val(vals.split("|"))
                        .trigger("change")
                        .on("select2:select select2:unselect", () => this.serializeAll())
                }
            }

            // key change
            if (keySel) {
                keySel.dataset.idx = idx
                keySel.addEventListener("change", e => this.keyChanged(e))
            }
            // remove row
            const rem = rowDiv.querySelector(".remove-filter-btn")
            if (rem) {
                rem.addEventListener("click", ev => {
                    ev.preventDefault()
                    rowDiv.remove()
                    this.serializeAll()
                })
            }

            this.rowsContainerTarget.appendChild(rowDiv)
        })

        this.serializeAll()
    }

    //─────────────────────────────────────────────────────
    // 6) bind form submit so we always serialize before submit
    //─────────────────────────────────────────────────────
    _bindFormSubmit() {
        const form = this.element.closest("form")
        if (form) {
            form.addEventListener("submit", () => this.serializeAll())
        }
    }
}
